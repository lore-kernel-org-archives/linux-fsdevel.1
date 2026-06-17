Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FBB481FA0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708481; cv=none; b=F0o3EE/8pHToO+xxdQCuoohbG1/h23WASYeELNnXMu7eoeG7mgjp9yg0Rcb/bbz31htf7OVjTGbDpegS1ClWqpLj2Nszyoa6PKNXYBwIS9s2QzLkgqW2lm5neyWv4n1d5JpLq/2Ur3mRf+w/CZjniiIajPTMEHddAZsReJf/h1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708481; c=relaxed/simple;
	bh=YaSASRB9dU6jXbCdjBgZMN5jcBYBy7PMMgiLbOMoWAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP34t4NBs9OwCml4Y7F0VHlEE7IfqaeEX5ZYeOBwuM9N+Qzl4v2Dt9qNDYFZ+s6SjAde7kGy9wtVL0xJIlQhgC0BHCz4etpUeU24o3pUV6kws7SFj+vU5PAxYmNS/BEZjEmpJRo+Lv3isjsF3yCiegPZf7xPuY2gANZekJdyHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSHLLEie; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSHLLEie"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4619990ca5fso2282691f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708475; x=1782313275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCmDWiw9X1Y88wXQqZoofqmRWSjRadgeJlYOOJoaDF0=;
        b=CSHLLEie/csnBa8EEzlFQ2eD/htltLkrWYoyjdbtHtpDhX+2JsaQdPFBEKJ+m7IHMI
         om2EuxluHHUD/5kHA4IwP53ystWyMyqr7EN1I4HB5cKZBoOL34bsbdaR9Jm1dYoIOjA0
         rE0rr7feeQ2cq/6NZVzQUan1lhDLgIJX36l3KP6ck86ot0VCam65vxDr7WM1p8Rq+kn2
         kRtlg6HQaKrYaVNLyy++SVpyzKzLdbIvXC4su0tJNCqC5WpuEnKiem4ybo0Z3tBUUj+v
         A7J7GWFqhzWWdy9GVmdGzZSDyc2s6bdZNb0lCO6W/9aTnGMo1wHw3jfXh5hAOiq8vkve
         bIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708475; x=1782313275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCmDWiw9X1Y88wXQqZoofqmRWSjRadgeJlYOOJoaDF0=;
        b=jljYgCLq4lhJx7bb2M/72qlxMsmCiWEnVZ3Hij+cUSoSue8L4mm2d1LCh7PvxtMq1+
         FQGQ5Hs/VLBnuMz1Veqougbh0J3hzXuHkoBxVs+SDA/p6mzdVkJ/qfK8WdbReeqY2sTu
         EV7sPKxo0SRtipzIg8VHLwTwfVZzjDJvnoYHAfechvSc1JrPLXdF/tYb4vOcGV7kSeq0
         Uj1hSQVU0hza6kLZAO0jk3p+ebvf+Z7LygNdxejed+pB0nRlkpB3NzsER8ldtoMZmj7b
         lAJh5gnVKM/5WSeKyVTM5HcY4AAQE2itD8rw1prPFwa0Ca+P8sHbcLxyhOeOUxXfb569
         RBSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Bd77VnXxbxhWaq/nPB24t/fed3GKctbSqv5JbzszeEDifjoHIvmWBCfJ0RIY3MhuJAE8TQXg8lK06M8kT@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUUF7qf5o9X2+49Z5UIioupTJgXCVQvlJ/1iw4DzwmY+y8Asv
	Z0Hu0fYhEY7X3rBEwEUrGBZxPI11nHxicFxyAhijEEOSTJLxk6ULnrbk
X-Gm-Gg: Acq92OH3cdj1+JI0WhPNMMQg6nLFACw2Ut0u432hD/yEWxd9plhxzhZB99rFkshnSx2
	R2NSW3sHzZE1jS6D1bRHy/td9RoFqaWKvPFXjKRQWxwBB4V3ryi9JD1IZhFx8XDLx1IV28IzDoB
	w9fJlrGw8G4zQirOLK0nHaIsKTUEZldawoQqAVqEjU1JDUtS2N/IpW6zrTm/mDYVoLc4TmYNsKU
	6oGuwCcZRJQYSFzRHkwsi8eapFSrmQPnOPjMG55CSIKvsoVSEVpc6xbyBYW2nC0hgSPaTLt6g1G
	XwdqJtTfb9ZmS+3p7uugEA4knrn0st3Bby9ITTAIB5c/wjC73PgoZ4+qmXMtFKpvOqhOrpcqzhB
	Jkn48d4IZOGAXgn/WHdJu9PeTaFCzXejnUnamxpKUoPawRozG+7A87huA0z+FNPnBQj10qdzEMu
	X7tysSxITidtiGfN0OAFhD9IuqmR4VzS9iTrTqDS7/ILNzePj41YrKzm+ueg==
X-Received: by 2002:a05:600c:80c1:b0:490:6e12:542d with SMTP id 5b1f17b1804b1-492333e2f1bmr64631955e9.19.1781708474437;
        Wed, 17 Jun 2026 08:01:14 -0700 (PDT)
Received: from f (cst-prg-84-90.cust.vodafone.cz. [46.135.84.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923756ff5csm9036615e9.0.2026.06.17.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:01:13 -0700 (PDT)
Date: Wed, 17 Jun 2026 17:01:04 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Josh Triplett <josh@joshtriplett.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <rlios6fzl4xc2p57aurth2bpt2iflskf6crabqi4u45f6mejbm@ekxu5ua6wa5c>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
 <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajJ1Xi1p9UhQvILi@gmail.com>

On Wed, Jun 17, 2026 at 03:23:54AM -0700, Breno Leitao wrote:
> Measured it to _just be sure_, 1-byte ping-pong (perf bench sched pipe -s 1):
> 
>     baseline:  2.674 usecs/op
>     patched:   2.710 usecs/op   (+1.3%, within run-to-run noise)
> 

Can you try this:

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c158f082f1da..012d9d87f827 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1118,11 +1118,14 @@ int fasync_helper(int fd, struct file * filp, int on, struct fasync_struct **fap
 
 EXPORT_SYMBOL(fasync_helper);
 
-/*
- * rcu_read_lock() is held
- */
-static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
+void __kill_fasync(struct fasync_struct **fp, int sig, int band)
 {
+	struct fasync_struct *fa;
+
+	guard(rcu)();
+
+	fa = rcu_dereference(*fp);
+
 	while (fa) {
 		struct fown_struct *fown;
 		unsigned long flags;
@@ -1148,19 +1151,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 		fa = rcu_dereference(fa->fa_next);
 	}
 }
-
-void kill_fasync(struct fasync_struct **fp, int sig, int band)
-{
-	/* First a quick test without locking: usually
-	 * the list is empty.
-	 */
-	if (*fp) {
-		rcu_read_lock();
-		kill_fasync_rcu(rcu_dereference(*fp), sig, band);
-		rcu_read_unlock();
-	}
-}
-EXPORT_SYMBOL(kill_fasync);
+EXPORT_SYMBOL(__kill_fasync);
 
 static int __init fcntl_init(void)
 {
diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec57..bea4e92bf0a8 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -426,7 +426,7 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			}
 
 			error = pipe_buf_confirm(pipe, buf);
-			if (error) {
+			if (unlikely(error)) {
 				if (!ret)
 					ret = error;
 				break;
@@ -541,7 +541,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * the same time, we could set up lockdep annotations for that, but
 	 * since we don't actually need that, it's simpler to just bail here.
 	 */
-	if (pipe_has_watch_queue(pipe))
+	if (unlikely(pipe_has_watch_queue(pipe)))
 		return -EXDEV;
 
 	/* Null write succeeds. */
@@ -552,7 +552,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 	mutex_lock(&pipe->mutex);
 
-	if (!pipe->readers) {
+	if (unlikely(!pipe->readers)) {
 		if ((iocb->ki_flags & IOCB_NOSIGNAL) == 0)
 			send_sig(SIGPIPE, current, 0);
 		ret = -EPIPE;
@@ -593,7 +593,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	for (;;) {
-		if (!pipe->readers) {
+		if (unlikely(!pipe->readers)) {
 			if ((iocb->ki_flags & IOCB_NOSIGNAL) == 0)
 				send_sig(SIGPIPE, current, 0);
 			if (!ret)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d10897b3a1e3..6f86d1fe7589 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1383,7 +1383,12 @@ extern struct fasync_struct *fasync_alloc(void);
 extern void fasync_free(struct fasync_struct *);
 
 /* can be called from interrupts */
-extern void kill_fasync(struct fasync_struct **, int, int);
+void __kill_fasync(struct fasync_struct **fp, int sig, int band);
+static inline void kill_fasync(struct fasync_struct **fp, int sig, int band)
+{
+	if (unlikely(*fp))
+		__kill_fasync(fp, sig, band);
+}
 
 extern void __f_setown(struct file *filp, struct pid *, enum pid_type, int force);
 extern int f_setown(struct file *filp, int who, int force);
