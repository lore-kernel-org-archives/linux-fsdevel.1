Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39F4D8DBD;
	Wed, 14 Oct 2026 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981042; cv=none; b=GTkGbEgb6cGlsGYed6RaZUY5vNOJd8KZN9zUD6iGRfZrK9u4sIzsKGP/E3KvhU7HNz8Dug90vBXveHvVvcarn4rqZC/3qC9z4SM/9MrTQ+0DJgg72F+RzrrGjO8XPgKC30OSSvTuis6ThQowW9eP2+k7kXEwpFCwQIUYqMjD7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981042; c=relaxed/simple;
	bh=wURsBdASOvDtP6/0IEv16KY+PL9RXXXq09cySwXTra4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ufL5Ef+J160S/0cwzju/4ntirsEBp/VzsE3GfOXPzV2UTQmNljXKo3FUpfyAzx3ljXYLLFwfq8ft8noGJ72esCFRI3y8OJrSOoMZWDs5t5qnXNA60R0ZnU0xyAseN1n6g8Ogx3jqcChKm9XpQ8fKy5y48SzUVU50NRnAIktHidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=XzhkUeGZ; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XzhkUeGZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=dVzAryIQs7MNYEL5viqcjwJasKo5xMZ33cgBx6sQVXw=; b=XzhkUeGZmp0gKhbIrWk
	PXayHLr7DEqWy5FYMbVqEdgXYaxu9d1/vTAS8/x0n1IrK27UikF0iQ5dn6cenmjOn3iJilWQOfDRB
	NtB/HDnpGz4KzTJ5i7XzSK9scOJa7Fo8BDcuyWvsJW1G2yRNftt8OJD/Iu70wUqx8ZjQRVnAefDxo
	ttbnDyHjWkTB698ljA/TN0+DDz2lccuEFHVbSkRLstinEJQgnbYFPzhfwP9x/HUAbpvNE7QMUxSIo
	6Ywbc3BPELsGslTPGOq7YfM3O5Ay5wNfIoY1X6fdmWdXttWN6wDi2fbvyN60cVCQuIg8bcH63Efw8
	sw+W+Yq0ldXov4Q==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xGy4W-002cn1-1Y;
	Wed, 14 Oct 2026 14:30:36 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 14 Oct 2026 14:30:33 +0200
Subject: [PATCH] binfmt_elf: return the real error when program headers
 cannot be loaded
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-v1-1-f39c74d55e42@virtuozzo.com>
X-B4-Tracking: v=1; b=H4sIAOh1z2oC/yXNWwrCMBBA0a2U+XagefioWxGRJpnYSPMgiUUo3
 bupfp6fe1colB0VuHYrZFpccTE0sEMHehrDk9CZZuA9P7GeSVQSU6aES6kxI5PDRZ5RuWB9fdB
 skUL05HGOo8HdaTK5oBiO1iqrhSAOrd0S1n1+39v97/JWL9J1n8G2fQH9A7KFmQAAAA==
X-Change-ID: 20261014-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-395ffbfc33e2
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Paul Burton <paulburton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10694;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=wURsBdASOvDtP6/0IEv16KY+PL9RXXXq09cySwXTra4=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBqz3XsyemZwhAUff41DZKx7XpMYOovAzeqJ7dOe
 iHQWKuabaGJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCas917AAKCRBRlgpH+WFc
 KnP4D/49Z7+8LA1QsQtQbG186T1hs8KDOtyJhPH6fFqEHTbeHJORRm+TvnIPGK7ru9KN7lFTjXu
 9UDl/uwKK6ZF8jv1XSIn1wt6njXc2I6/NDYXcFOMevmxGE5H/Hf98Dzy12jzTPSTlit3VNloI91
 pkGuqbRsSfLq7NqjmEHlRxbDwwB7rJ94+w61sOTW5zaMWK1/OlfhEJkpFajcvga+3ALJSGEboJS
 tjOErpSq0sJCuWeUngUwZM+CmgXtQ8gMydpLRGjo7ZeBO+kE9QHmEtGg2OdQCJOBl3joL5ZzjBy
 0sMLs6JY/SrA5oNKe7ZRh4019LvLr03kxtEHCZXXywyHw5tnuuzeaC+x8lztBD+LADr8YhwFI+q
 cQ53zhopUIAxSsGohVD8wM0qfmWqQQtSfRrdbdQSL/MkB1LT/BxhPHd2pmYy6S6TnCDc9fzQOYV
 7QyQWq6kWMBk9lBuvj8cTH55VuwXZP/JHZsAyWqHvi4k0hwvZp5ZZ6ijB0RSW3qCsIgwemYFdsg
 Gm0/DBTsILMkY6yt/ENo/OrqtCJBR0YdOuRQ8r4X599gU9ogqFULznxW46JOXfld2OFY5AGST5h
 +Syi4WfBIqC0x2c5rJcr2nwE+UuJDb898p+bqDZdjjMmginB5V6Swih05Kp/uXMv3EPemP2R97f
 lPmnogcKdYHzNfw==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

load_elf_phdrs() returns NULL on any failure, and load_elf_binary()
turns that into -ENOEXEC for the executable and -ELIBBAD for its
interpreter. So a failed allocation or read of the program headers
makes glibc's execvp() run the ELF file with /bin/sh, and reports a
healthy ld.so as a corrupted shared library.

Return an ERR_PTR instead, as binfmt_elf_fdpic does:

  -ENOEXEC     bad e_phentsize, e_phnum or e_phoff, or the file ends
               before the header table
  -ENOMEM      the allocation fails
  read error   kernel_read() fails

Malformed files keep getting -ENOEXEC and -ELIBBAD. kernel_read()
returns a short count when a later page fails, so read on until the
error or the end of the file shows. An e_phoff past LLONG_MAX - size
is rejected up front, as rw_verify_area() would turn it into -EINVAL.

Fixes: 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to a function")
Fixes: a9d9ef133f44 ("binfmt_elf: load interpreter program headers earlier")
Assisted-by: LLM
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
Problem
=======

load_elf_phdrs() returns NULL on any failure, and load_elf_binary()
turns that into a fixed error: -ENOEXEC for the executable, -ELIBBAD
for its interpreter. The real cause is lost:

  cause                                  really      execve() returns
  -------------------------------------  ----------  ----------------
  bad e_phentsize, e_phnum 0 or too big  bad file    ENOEXEC (right)
  file ends before the header table      bad file    ENOEXEC (right)
  kmalloc() of the table fails           ENOMEM      ENOEXEC (wrong)
  kernel_read() fails                    EIO/ENOMEM  ENOEXEC (wrong)

For the interpreter every row gives ELIBBAD.

Consequences
============

ENOEXEC says the file is not an executable, which is a property of the
file, not a transient failure:

- glibc's execvp() and execlp() take ENOEXEC as "not a binary" and run
  the ELF file with /bin/sh, which reports a binary it cannot execute
  instead of the ENOMEM or EIO.
- search_binary_handler() tries the next binary format instead of
  returning the error.
- For the interpreter the caller gets ELIBBAD, "Accessing a corrupted
  shared library", about an ld.so that is fine.
- A caller that would retry on ENOMEM or report EIO gives up on the
  file instead.

When it happens
===============

- The allocation fails under fault injection. Since commit
  8030790477e8 ("binfmt_elf: remove the 4k limitation of program header
  size") the table may be up to 64K; above 32K that is an order-4
  allocation on 4K-page kernels, which can fail on a fragmented system.
- The read fails with an I/O error, or with -ENOMEM when the page cache
  cannot take the pages.

Where it came from
==================

- Until commit 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header
  loading to a function") load_elf_binary() returned -ENOMEM and the
  read error. That commit documented an ERR_PTR return but returned
  NULL; commit cfc46ca4fdca later fixed the comment, not the code.
- Commit a9d9ef133f44 ("binfmt_elf: load interpreter program headers
  earlier") gave the interpreter's headers the same NULL check, and with
  it -ELIBBAD.

Hence the two Fixes tags.

Testing
=======

With failslab on v7.3-rc7 (CONFIG_FAILSLAB,
CONFIG_FAULT_INJECTION_DEBUG_FS, failslab/ignore-gfp-wait = N): write n
to /proc/thread-self/fail-nth, then execvp("/bin/true"). At the n that
hits the program header allocation of /bin/true, /bin/sh (bash here)
gets the file:

    /bin/true: /bin/true: cannot execute binary file    (exit 126)

while the allocations around it give "execvp: Cannot allocate memory".

The reproducer below does the same with execve() for n = 1, 2, ...
until 50 execve() calls in a row return no error, on /bin/true
(dynamically linked):

  kernel                errors returned by execve()
  7.3-rc7               ENOMEM 17, ENOEXEC 1, ELIBBAD 1, E2BIG 2
  7.3-rc7 + this patch  ENOMEM 19, E2BIG 2

- ENOEXEC is the executable's header array, ELIBBAD the interpreter's.
- The two E2BIG come from copy_string_kernel() of the file name, whose
  first write to the new stack fails in get_arg_page(); that is a
  separate issue, not touched here.
- failslab does not reach header tables above 8K, which go to the page
  allocator, nor the read errors, so these rows show only the
  allocation half.
- For the read: a copy of /bin/true with its header table moved across
  offset 4096, served from a FUSE file with direct_io whose reads stop
  at 4096 and fail with EIO past it. execve() returns EIO with the
  patch; the old code turns the first, short read into ENOEXEC.
- A truncated header table, and an e_phoff of 2^63 that kernel_read()
  would refuse with EINVAL, still give ENOEXEC for the executable and
  ELIBBAD for the interpreter.

Reproducer (gcc -O2 -o exec_fail_nth exec_fail_nth.c; run as root):

    // SPDX-License-Identifier: GPL-2.0
    /*
     * Fail the n-th fault injection point (here: slab allocations) of an
     * execve() for n = 1, 2, ... until 50 execve() calls in a row return no
     * error, and count the errors execve() returns. Needs CONFIG_FAILSLAB and
     * CONFIG_FAULT_INJECTION_DEBUG_FS, and failslab set up to fail sleeping
     * allocations:
     *	echo N > /sys/kernel/debug/failslab/ignore-gfp-wait
     *
     * usage: exec_fail_nth [program]	(default /bin/true)
     */
    #define _GNU_SOURCE
    #include <errno.h>
    #include <fcntl.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <unistd.h>
    #include <sys/wait.h>

    int main(int argc, char **argv)
    {
    	char *prog = argc > 1 ? argv[1] : "/bin/true";
    	char *args[] = { prog, NULL };
    	int counts[256] = { 0 }, clean = 0, n, e;

    	for (n = 1; clean < 50 && n < 100000; n++) {
    		int p[2];
    		pid_t pid;

    		if (pipe2(p, O_CLOEXEC))
    			return 2;
    		pid = fork();
    		if (pid < 0)
    			return 2;
    		if (!pid) {
    			char buf[16];
    			int fd = open("/proc/thread-self/fail-nth", O_WRONLY);

    			if (fd < 0 || write(fd, buf, sprintf(buf, "%d", n)) < 0)
    				_exit(3);
    			execve(prog, args, NULL);
    			e = errno;
    			write(p[1], &e, sizeof(e));
    			_exit(4);
    		}
    		close(p[1]);
    		if (read(p[0], &e, sizeof(e)) == sizeof(e)) {
    			counts[e & 255]++;
    			if (e == ENOEXEC || e == ELIBBAD)
    				printf("n=%d: execve() failed with %s\n", n, strerrorname_np(e));
    			clean = 0;
    		} else {
    			clean++;
    		}
    		close(p[0]);
    		if (waitpid(pid, &e, 0) == pid && WIFEXITED(e) && WEXITSTATUS(e) == 3) {
    			fprintf(stderr, "cannot write /proc/thread-self/fail-nth\n");
    			return 2;
    		}
    	}
    	printf("n = 1..%d, execve() errors:", n - 1);
    	for (e = 0; e < 256; e++)
    		if (counts[e])
    			printf(" %s=%d", strerrorname_np(e), counts[e]);
    	printf("\n");
    	if (n - 1 == clean) {
    		fprintf(stderr, "no allocation failed: is failslab/ignore-gfp-wait N?\n");
    		return 2;
    	}
    	return counts[ENOEXEC] || counts[ELIBBAD];
    }
---
 fs/binfmt_elf.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 06d0df1053823..05e03f1c9f3f6 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -512,39 +512,47 @@ static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
  *
  * Loads ELF program headers from the binary file elf_file, which has the ELF
  * header pointed to by elf_ex, into a newly allocated array. The caller is
- * responsible for freeing the allocated data. Returns NULL upon failure.
+ * responsible for freeing the allocated data. Returns an ERR_PTR upon failure:
+ * -ENOEXEC for a malformed header or when the read reaches the end of the
+ * file, the allocation or read error otherwise.
  */
 static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 				       struct file *elf_file)
 {
-	struct elf_phdr *elf_phdata = NULL;
-	int retval = -1;
-	unsigned int size;
+	struct elf_phdr *elf_phdata;
+	unsigned int size, done;
+	loff_t pos;
+	ssize_t rv;
 
 	/*
 	 * If the size of this structure has changed, then punt, since
 	 * we will be doing the wrong thing.
 	 */
 	if (elf_ex->e_phentsize != sizeof(struct elf_phdr))
-		goto out;
+		return ERR_PTR(-ENOEXEC);
 
 	/* Sanity check the number of program headers... */
-	/* ...and their total size. */
+	/* ...their total size and their offset. */
 	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
-	if (size == 0 || size > 65536)
-		goto out;
+	if (size == 0 || size > 65536 || elf_ex->e_phoff > LLONG_MAX - size)
+		return ERR_PTR(-ENOEXEC);
 
 	elf_phdata = kmalloc(size, GFP_KERNEL);
 	if (!elf_phdata)
-		goto out;
-
-	/* Read in the program headers */
-	retval = elf_read(elf_file, elf_phdata, size, elf_ex->e_phoff);
+		return ERR_PTR(-ENOMEM);
 
-out:
-	if (retval) {
-		kfree(elf_phdata);
-		elf_phdata = NULL;
+	/*
+	 * Read in the program headers. A read that fails part way returns
+	 * what it got, so read on to see the error or the end of the file.
+	 */
+	pos = elf_ex->e_phoff;
+	for (done = 0; done < size; done += rv) {
+		rv = kernel_read(elf_file, (char *)elf_phdata + done,
+				 size - done, &pos);
+		if (rv <= 0) {
+			kfree(elf_phdata);
+			return ERR_PTR(rv ? rv : -ENOEXEC);
+		}
 	}
 	return elf_phdata;
 }
@@ -864,8 +872,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 
 	elf_phdata = load_elf_phdrs(elf_ex, bprm->file);
-	if (!elf_phdata)
+	if (IS_ERR(elf_phdata)) {
+		retval = PTR_ERR(elf_phdata);
 		goto out;
+	}
 
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
@@ -968,8 +978,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		/* Load the interpreter program headers */
 		interp_elf_phdata = load_elf_phdrs(interp_elf_ex,
 						   interpreter);
-		if (!interp_elf_phdata)
+		if (IS_ERR(interp_elf_phdata)) {
+			if (PTR_ERR(interp_elf_phdata) != -ENOEXEC)
+				retval = PTR_ERR(interp_elf_phdata);
+			interp_elf_phdata = NULL;
 			goto out_free_dentry;
+		}
 
 		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
 		elf_property_phdata = NULL;

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-395ffbfc33e2

Best regards,
--  
Konstantin Khorenko <khorenko@virtuozzo.com>

