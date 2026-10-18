Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC4332EAE;
	Sun, 18 Oct 2026 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292148; cv=none; b=DxbR0plajIX729JY3bhdcxivNcp8NP6a0q4FMAQakwpTIaiq4foPJBiQDGqOglMnhcuI2VtdaFhni89Zpi/1UMZzjC98svEnEBTWfh9+9J/HzKJDMoTG+H0fvy/jDY1DcdQriHNd8GgP6C7B6Byhvc+vAuyIjL4iX5c4wYdeiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292148; c=relaxed/simple;
	bh=XFsqnkhAoyYGTF88mgBQ1fcnUIdUfTLVik086Lc5+2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RoFAMwhO6XXkZulrpsg8O8unmsm+7XDx6UkaziokjJ7bIRsuyHXq17AqvOfFw/d8JdPuq26mbWzZA56LHy2FJHtqpHPa3vO7bg9mYHnSeHMjqr6anzqduNYZilhLYnHfVlkiRXMMBNAN5xn+fW/zn3UYCESKUfKLuPZH6lrTKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xIH3l-004RVH-E7;
	Sat, 17 Oct 2026 22:55:41 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1] splice: retry tee() instead of returning 0 when it races
Date: Sat, 17 Oct 2026 22:55:41 -0400
Message-ID: <20261018025541.799135-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tee() can return 0 while the input pipe still has writers, when
another task reads the input pipe or fills the output pipe at the same
time. tee(2) documents 0 as "no data was copied" because the input pipe
has no writers, and loops built on it (the man page example breaks out
on 0) stop early. In a test with one thread writing 1 byte at a time
to the input pipe, one reading it and one draining the output pipe,
about one tee() call in 150 returned 0.

do_tee() runs ipipe_prep() and opipe_prep() to wait for data and room,
each under its own pipe lock, and only then takes both locks in
link_pipe(). If the input pipe was emptied or the output pipe filled in
between, link_pipe() finds nothing to do and returns 0.
splice_pipe_to_pipe(), which was modelled on tee(), handles the same
race by dropping both locks and going back to the prep steps ("A zero
return value means EOF, so retry instead"), and returns -EAGAIN for
SPLICE_F_NONBLOCK.

Do the same in link_pipe(): move the prep steps into it and retry when
nothing was linked although the input pipe still has writers.

Tested under QEMU (x86_64) with the program in the notes: 154 of 22698
tee() calls returned 0 before the change, none of 34429 after it.

Fixes: aadd06e5c56b ("[PATCH] splice: fix problems with sys_tee()")
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    Reproducer:
    
    #define _GNU_SOURCE
    #include <fcntl.h>
    #include <pthread.h>
    #include <stdio.h>
    #include <time.h>
    #include <unistd.h>
    
    static int a[2], b[2];
    static volatile int stop;
    
    static void *writer(void *arg)
    {
    	while (!stop)
    		if (write(a[1], "x", 1) < 0)
    			break;
    	return NULL;
    }
    
    static void *drain(void *arg)
    {
    	char buf[4096];
    	int fd = *(int *)arg;
    
    	while (!stop)
    		if (read(fd, buf, sizeof(buf)) < 0)
    			break;
    	return NULL;
    }
    
    int main(void)
    {
    	pthread_t t[3];
    	long calls = 0, zero = 0;
    	ssize_t ret;
    
    	if (pipe(a) || pipe(b))
    		return 1;
    	pthread_create(&t[0], NULL, writer, NULL);
    	pthread_create(&t[1], NULL, drain, &a[0]);	/* concurrent reader of the tee input */
    	pthread_create(&t[2], NULL, drain, &b[0]);	/* keeps the tee output from filling */
    	for (time_t end = time(NULL) + 5; time(NULL) < end; calls++) {
    		ret = tee(a[0], b[1], 65536, 0);
    		if (ret == 0)
    			zero++;
    		else if (ret < 0)
    			perror("tee");
    	}
    	printf("%ld tee() calls, %ld returned 0 while the input pipe had a writer\n",
    	       calls, zero);
    	return zero != 0;
    }
    
    gcc -O2 -pthread -o tee-race tee-race.c && ./tee-race
    
    Before: 22698 tee() calls, 154 returned 0 while the input pipe had a writer
    After:  34429 tee() calls, 0 returned 0 while the input pipe had a writer
    
    tee() with SPLICE_F_NONBLOCK on an empty pipe with a writer still returns
    -EAGAIN, a tee() of queued data still leaves the data in the input pipe,
    and an empty input pipe without writers still returns 0.

 fs/splice.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1a..baadec16d6df 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1856,6 +1856,15 @@ static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 	unsigned int i_tail, o_tail;
 	ssize_t ret = 0;
 
+retry:
+	ret = ipipe_prep(ipipe, flags);
+	if (ret)
+		return ret;
+
+	ret = opipe_prep(opipe, flags);
+	if (ret)
+		return ret;
+
 	/*
 	 * Potential ABBA deadlock, work around it by ordering lock
 	 * grabbing by pipe info address. Otherwise two different processes
@@ -1877,13 +1886,32 @@ static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 		i_head = ipipe->head;
 		o_tail = opipe->tail;
 
+		if (pipe_empty(i_head, i_tail) && !ipipe->writers)
+			break;
+
 		/*
 		 * If we have iterated all input buffers or run out of
 		 * output room, break.
 		 */
 		if (pipe_empty(i_head, i_tail) ||
-		    pipe_full(o_head, o_tail, opipe->max_usage))
-			break;
+		    pipe_full(o_head, o_tail, opipe->max_usage)) {
+			if (ret)
+				break;
+
+			if (flags & SPLICE_F_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
+			}
+
+			/*
+			 * We raced with another reader/writer and haven't
+			 * linked any buffers. A zero return value means EOF,
+			 * so retry instead.
+			 */
+			pipe_unlock(ipipe);
+			pipe_unlock(opipe);
+			goto retry;
+		}
 
 		ibuf = pipe_buf(ipipe, i_tail);
 		obuf = pipe_buf(opipe, o_head);
@@ -1954,16 +1982,7 @@ ssize_t do_tee(struct file *in, struct file *out, size_t len,
 		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-		/*
-		 * Keep going, unless we encounter an error. The ipipe/opipe
-		 * ordering doesn't really matter.
-		 */
-		ret = ipipe_prep(ipipe, flags);
-		if (!ret) {
-			ret = opipe_prep(opipe, flags);
-			if (!ret)
-				ret = link_pipe(ipipe, opipe, len, flags);
-		}
+		ret = link_pipe(ipipe, opipe, len, flags);
 	}
 
 	if (ret > 0) {

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.53.0

