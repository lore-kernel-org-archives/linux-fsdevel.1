Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCE3D75DD
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669131; cv=none; b=XHz8a01Ma7M1UTOQRwiG02D7R1DIT3ScLOfn5O0YxXdp91+bQSEdg1+n+NMh87uizdVh5aSTqMLYRZJ37nibxVf+kI5I7Nkv+4//rOClZ/0j5XxJcP7WtO36+pngT15hXPAeKFy5GnHZ8b6fCwm/SAHFTjSG8r6Yz+ntOUIEv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669131; c=relaxed/simple;
	bh=sVyOqSuKK31rgTue4uvQiahhS1FfzPeaeQi3ygSoaqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jx02ClmIpIRrbqSCtaS24eKZr5R8h/C2ir7fCcunehK//9gNLd9H8e9TdTF4b9AdE8Xt7UXfS68m+Lgs0JLIdWSidgEuzQDLseMSLguIneE+4wPFkNAeU7gvmy6zEgfPhsJMK+VrtTVIKQGW8/O+eJSXjVurbFcYJPe7H8y6Cnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SycBMjRa; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SycBMjRa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775669127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jv7R7lRthgcrO9PPVAeU4iCNg5RLQONuhbbZQkJ3z+g=;
	b=SycBMjRaAd1RmJ0eFH3pDgf8jVXOWe6h0BtZfldEorYeXQcSKNJ69RGEdxtELOb2FjaTV7
	HMvh7BMAu0o4PZlkPUfkqbG5+AUZatVHHVyNP1szi0dsDbB4nlB9PsyyP/l+GouKrtKfga
	tlWaU3B7pzaq7COMm+RJbDhzsnfXy7Q=
From: wen.yang@linux.dev
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH v5 1/2] eventfd: add configurable per-fd counter maximum for flow control
Date: Thu,  9 Apr 2026 01:24:48 +0800
Message-Id: <530e8b5e22e08f8459d335eaf31ff78b999fa5cf.1775668339.git.wen.yang@linux.dev>
In-Reply-To: <cover.1775668339.git.wen.yang@linux.dev>
References: <cover.1775668339.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

In non-semaphore mode, write(2) accumulates into the counter and a
single read(2) drains it entirely. A producer issuing repeated
write(1) calls coalesces N signals into the counter; each write
succeeds immediately regardless of whether the consumer has processed
earlier events. With no bound below ULLONG_MAX (~1.8×10¹⁹), the
counter grows without bound, consumer lag is invisible to the producer,
and in tight loops both sides burn CPU at 100% even though the consumer
is not keeping up. Without a maximum, the batch size seen by each
read(2) is also unbounded: a slow consumer may drain thousands of
accumulated signals in one call, losing visibility into how far behind
it has fallen.

Introduce two ioctl commands:

  EFD_IOC_SET_MAXIMUM  (_IOW('J', 0, __u64))
    Set the overflow threshold. A write(2) that would push the counter
    to or beyond this value blocks (EAGAIN for O_NONBLOCK fds).
    Returns -EINVAL if the requested maximum is <= the current counter.
    Wakes any blocked writers so they re-evaluate the new limit without
    waiting for the next read(2).

  EFD_IOC_GET_MAXIMUM  (_IOR('J', 1, __u64))
    Return the current threshold. Defaults to ULLONG_MAX, preserving
    the original unlimited behaviour. The value is also visible in
    /proc/self/fdinfo as "eventfd-maximum".

The maximum acts as the overflow level, exactly as ULLONG_MAX did in the
original design: the kernel-internal eventfd_signal() path may still
raise the counter to maximum (triggering EPOLLERR), while userspace
writes are capped at maximum-1.

This follows the backpressure pattern established by pipe(2): writers
block when the buffer is full, and capacity is adjustable via
fcntl(F_SETPIPE_SZ). POSIX message queues apply the same model:
mq_send(3) blocks when the queue depth reaches mq_maxmsg.

The following self-contained program covers three benchmarks. Build and
run with:  gcc -O2 -lpthread bench.c -o bench && ./bench

  /* bench.c */
  #define _GNU_SOURCE
  #include <errno.h>
  #include <inttypes.h>
  #include <poll.h>
  #include <pthread.h>
  #include <sched.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/eventfd.h>
  #include <sys/ioctl.h>
  #include <time.h>
  #include <unistd.h>
  #include <linux/eventfd.h>

  #define SECS  5
  #define MAX   10ULL
  #define LAT_N 5000
  #define COAL_N 10000ULL
  #define WINT  100000ULL   /* 100 µs → 10 K events/s */
  #define RSLT  125000ULL   /* 125 µs → ~8 K events/s */

  /* helpers */
  static uint64_t cpu_ms(void) {
  	struct timespec t;
  	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &t);
  	return (uint64_t)t.tv_sec * 1000 + t.tv_nsec / 1000000;
  }
  static uint64_t mono_ns(void) {
  	struct timespec t;
  	clock_gettime(CLOCK_MONOTONIC, &t);
  	return (uint64_t)t.tv_sec * 1000000000ULL + t.tv_nsec;
  }
  static void set_max(int fd, uint64_t m) {
  	if (m) ioctl(fd, EFD_IOC_SET_MAXIMUM, &m);
  }
  static void maxstr(char *b, uint64_t m) {
  	if (!m) snprintf(b, 24, "ULLONG_MAX");
  	else    snprintf(b, 24, "%llu", (unsigned long long)m);
  }

  /* bench 1: burst/CPU savings */
  enum mode { BLOCKING, SPIN, POLL_OUT };
  static int burst_fd; static volatile int stop;
  static enum mode wmode;
  static uint64_t wcpu, rcpu, neagain, nwrites, nreads;

  static void *burst_writer(void *_) {
  	(void)_;
  	uint64_t v=1, n=0, ea=0, t0=cpu_ms();
  	struct pollfd p={.fd=burst_fd,.events=POLLOUT};
  	while (!stop) {
  		if      (wmode==BLOCKING) { if (write(burst_fd,&v,8)==8) n++; }
  		else if (wmode==SPIN)     { if (write(burst_fd,&v,8)<0 && errno==EAGAIN) ea++; else n++; }
  		else { while (!stop && !(poll(&p,1,20)>0 && p.revents&POLLOUT));
  		       if (write(burst_fd,&v,8)==8) n++; }
  	}
  	wcpu=cpu_ms()-t0; neagain=ea; nwrites=n; return NULL;
  }
  static void *burst_reader(void *_) {
  	(void)_;
  	struct pollfd p={.fd=burst_fd,.events=POLLIN};
  	uint64_t v, nr=0, t0=cpu_ms();
  	while (stop==0 || (poll(&p,1,0)>0 && p.revents&POLLIN))
  		if (poll(&p,1,5)>0 && read(burst_fd,&v,8)==8) { nr++; usleep(1000); }
  	rcpu=cpu_ms()-t0; nreads=nr; return NULL;
  }
  static void run_burst(const char *lbl, enum mode m, uint64_t max) {
  	burst_fd=eventfd(0, m!=BLOCKING ? EFD_CLOEXEC|EFD_NONBLOCK : EFD_CLOEXEC);
  	set_max(burst_fd, max); wmode=m; stop=0;
  	pthread_t w,r;
  	pthread_create(&r,NULL,burst_reader,NULL); pthread_create(&w,NULL,burst_writer,NULL);
  	cpu_set_t c;
  	CPU_ZERO(&c); CPU_SET(0,&c); pthread_setaffinity_np(r,sizeof(c),&c);
  	CPU_ZERO(&c); CPU_SET(1,&c); pthread_setaffinity_np(w,sizeof(c),&c);
  	sleep(SECS); stop=1;
  	pthread_join(w,NULL); pthread_join(r,NULL); close(burst_fd);
  	char mb[24]; maxstr(mb, max);
  	printf("  %-22s  %-12s  %8llu  %8llu  %10llu  %10llu  %8llu\n", lbl, mb,
  	       (unsigned long long)wcpu, (unsigned long long)rcpu,
  	       (unsigned long long)neagain,
  	       (unsigned long long)nwrites, (unsigned long long)nreads);
  }

  /* bench 2: latency tail (EFD_SEMAPHORE) */
  static int latency_fd;
  static uint64_t wts[LAT_N], rts[LAT_N];

  static void *latency_writer(void *_) {
  	(void)_; uint64_t v=1, next=mono_ns();
  	for (int i=0; i<LAT_N; i++) {
  		while (mono_ns()<next); next+=WINT;
  		wts[i]=mono_ns();
  		int r; do { r=write(latency_fd,&v,8); } while (r<0 && errno==EINTR);
  	}
  	return NULL;
  }
  static void *latency_reader(void *_) {
  	(void)_; struct pollfd p={.fd=latency_fd,.events=POLLIN}; uint64_t v;
  	for (int i=0; i<LAT_N; i++) {
  		while (poll(&p,1,200)<=0 || !(p.revents&POLLIN));
  		(void)read(latency_fd,&v,8); rts[i]=mono_ns();
  		uint64_t w=mono_ns()+RSLT; while (mono_ns()<w);
  	}
  	return NULL;
  }
  static int cmp64(const void *a, const void *b) {
  	uint64_t x=*(const uint64_t*)a, y=*(const uint64_t*)b;
  	return (x>y)-(x<y);
  }
  static void run_latency(uint64_t max) {
  	latency_fd=eventfd(0, EFD_CLOEXEC|EFD_SEMAPHORE); set_max(latency_fd, max);
  	pthread_t w,r;
  	pthread_create(&r,NULL,latency_reader,NULL); pthread_create(&w,NULL,latency_writer,NULL);
  	pthread_join(w,NULL); pthread_join(r,NULL); close(latency_fd);
  	uint64_t lat[LAT_N];
  	for (int i=0; i<LAT_N; i++) lat[i]=rts[i]-wts[i];
  	qsort(lat,LAT_N,sizeof(lat[0]),cmp64);
  	char mb[24]; maxstr(mb, max);
  	printf("  %-12s  %10.0f  %10.0f  %10.0f\n", mb,
  	       lat[LAT_N*99/100]/1000.0, lat[LAT_N*999/1000]/1000.0,
  	       lat[LAT_N-1]/1000.0);
  }

  /* bench 3: coalescing (non-EFD_SEMAPHORE) */
  static int coal_fd;
  static uint64_t coal_reads;

  static void *coal_writer(void *_) {
  	(void)_; uint64_t v=1;
  	for (uint64_t i=0; i<COAL_N; i++) {
  		int r; do { r=write(coal_fd,&v,8); } while (r<0 && errno==EINTR);
  	}
  	return NULL;
  }
  static void *coal_reader(void *_) {
  	(void)_; uint64_t v, nr=0, tot=0;
  	while (tot < COAL_N) {
  		(void)read(coal_fd,&v,8); nr++; tot+=v;
  		uint64_t w=mono_ns()+RSLT; while(mono_ns()<w);
  	}
  	coal_reads=nr; return NULL;
  }
  static void run_coalesce(uint64_t max) {
  	coal_fd=eventfd(0, EFD_CLOEXEC); set_max(coal_fd, max);
  	pthread_t w,r;
  	pthread_create(&r,NULL,coal_reader,NULL); pthread_create(&w,NULL,coal_writer,NULL);
  	pthread_join(w,NULL); pthread_join(r,NULL); close(coal_fd);
  	char mb[24]; maxstr(mb, max);
  	printf("  %-12s  %10llu  %8llu  %10.1f\n", mb,
  	       (unsigned long long)COAL_N,
  	       (unsigned long long)coal_reads,
  	       (double)COAL_N/coal_reads);
  }

  /* main */
  int main(void) {
  	printf("\nBench 1 – burst/CPU  (writer vs reader, %ds)\n", SECS);
  	printf("  %-22s  %-12s  %8s  %8s  %10s  %10s  %8s\n",
  	       "writer_mode","maximum","wcpu_ms","rcpu_ms","EAGAIN","writes","reads");
  	printf("  -----------------------------------------------------------------------\n");
  	run_burst("blocking, no limit", BLOCKING, 0);
  	run_burst("blocking",          BLOCKING, MAX);
  	run_burst("O_NONBLOCK+spin",   SPIN,     MAX);
  	run_burst("O_NONBLOCK+poll",   POLL_OUT, MAX);

  	printf("\nBench 2 – latency tail"
  	       "  (EFD_SEMAPHORE, 10K/s writer, ~8K/s reader, %d events)\n",
  	       LAT_N);
  	printf("  %-12s  %10s  %10s  %10s\n",
  	       "maximum","p99_us","p999_us","max_us");
  	printf("  -------------------------------------------\n");
  	static const uint64_t mv[]={0,100,10};
  	for (int i=0;i<3;i++) run_latency(mv[i]);

  	printf("\nBench 3 – coalescing"
  	       "  (non-EFD_SEMAPHORE, %llu writes, 125us/read reader)\n",
  	       (unsigned long long)COAL_N);
  	printf("  %-12s  %10s  %8s  %10s\n",
  	       "maximum","writes","reads","avg_batch");
  	printf("  -----------------------------------------------\n");
  	static const uint64_t cv[]={0,100,10};
  	for (int i=0;i<3;i++) run_coalesce(cv[i]);
  }

On a 4-core x86_64 (writer and reader pinned to separate CPUs,
reader sleeps 1 ms between reads to simulate processing time):

  Bench 1 – burst/CPU  (writer vs reader, 5s)
  writer_mode             maximum       wcpu_ms  rcpu_ms      EAGAIN      writes    reads
  -------------------------------------------------------------------------
  blocking, no limit      ULLONG_MAX       5002      132           0     6517388     4506
  blocking                10                133      150           0       40456     4496
  O_NONBLOCK+spin         10               4999      126     5789340       40568     4508
  O_NONBLOCK+poll         10                189      151           0       40519     4503

  Bench 2 – latency tail  (EFD_SEMAPHORE, 10K/s writer, ~8K/s reader, 5000 events)
  maximum        p99_us    p999_us     max_us
  -------------------------------------------
  ULLONG_MAX     141218     142477     142588
  100             13298      13320      13334
  10               1719       2378       2381

  Bench 3 – coalescing  (non-EFD_SEMAPHORE, 10000 writes, 125us/read reader)
  maximum           writes    reads   avg_batch
  -----------------------------------------------
  ULLONG_MAX         10000       79      126.6
  100                10000      105       95.2
  10                 10000     1121        8.9

With maximum=10: burst CPU drops >97% (5002 ms → 133 ms); latency p999
drops ~60x (142 ms → 2.4 ms); coalescing batch size is bounded to 9
(vs 127 without a limit), so the consumer always knows the backlog is
small. O_NONBLOCK+spin bypasses flow control entirely — use
poll(POLLOUT)+write to get the same benefit as a blocking write while
still multiplexing other fds in a single poll(2) call.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/eventfd.c                                  | 74 ++++++++++++++++---
 include/uapi/linux/eventfd.h                  |  6 ++
 3 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 331223761fff..d233559179b1 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -170,6 +170,7 @@ Code  Seq#    Include File                                             Comments
 'I'   all    linux/isdn.h                                              conflict!
 'I'   00-0F  drivers/isdn/divert/isdn_divert.h                         conflict!
 'I'   40-4F  linux/mISDNif.h                                           conflict!
+'J'   00-01  linux/eventfd.h                                           eventfd ioctl
 'K'   all    linux/kd.h
 'L'   00-1F  linux/loop.h                                              conflict!
 'L'   10-1F  drivers/scsi/mpt3sas/mpt3sas_ctl.h                        conflict!
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 3219e0d596fe..11985d07e904 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -39,6 +39,7 @@ struct eventfd_ctx {
 	 * also, adds to the "count" counter and issue a wakeup.
 	 */
 	__u64 count;
+	__u64 maximum;
 	unsigned int flags;
 	int id;
 };
@@ -49,9 +50,9 @@ struct eventfd_ctx {
  * @mask: [in] poll mask
  *
  * This function is supposed to be called by the kernel in paths that do not
- * allow sleeping. In this function we allow the counter to reach the ULLONG_MAX
- * value, and we signal this as overflow condition by returning a EPOLLERR
- * to poll(2).
+ * allow sleeping. In this function we allow the counter to reach the maximum
+ * value (ctx->maximum), and we signal this as overflow condition by returning
+ * a EPOLLERR to poll(2).
  */
 void eventfd_signal_mask(struct eventfd_ctx *ctx, __poll_t mask)
 {
@@ -70,7 +71,7 @@ void eventfd_signal_mask(struct eventfd_ctx *ctx, __poll_t mask)
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
 	current->in_eventfd = 1;
-	if (ctx->count < ULLONG_MAX)
+	if (ctx->count < ctx->maximum)
 		ctx->count++;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN | mask);
@@ -119,7 +120,7 @@ static __poll_t eventfd_poll(struct file *file, poll_table *wait)
 {
 	struct eventfd_ctx *ctx = file->private_data;
 	__poll_t events = 0;
-	u64 count;
+	u64 count, max;
 
 	poll_wait(file, &ctx->wqh, wait);
 
@@ -162,12 +163,13 @@ static __poll_t eventfd_poll(struct file *file, poll_table *wait)
 	 *     eventfd_poll returns 0
 	 */
 	count = READ_ONCE(ctx->count);
+	max = READ_ONCE(ctx->maximum);
 
 	if (count > 0)
 		events |= EPOLLIN;
-	if (count == ULLONG_MAX)
+	if (count == max)
 		events |= EPOLLERR;
-	if (ULLONG_MAX - 1 > count)
+	if (max - 1 > count)
 		events |= EPOLLOUT;
 
 	return events;
@@ -244,6 +246,11 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	return sizeof(ucnt);
 }
 
+static inline bool eventfd_is_writable(struct eventfd_ctx *ctx, __u64 cnt)
+{
+	return ctx->maximum > ctx->count && ctx->maximum - ctx->count > cnt;
+}
+
 static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t count,
 			     loff_t *ppos)
 {
@@ -259,11 +266,11 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 		return -EINVAL;
 	spin_lock_irq(&ctx->wqh.lock);
 	res = -EAGAIN;
-	if (ULLONG_MAX - ctx->count > ucnt)
+	if (eventfd_is_writable(ctx, ucnt))
 		res = sizeof(ucnt);
 	else if (!(file->f_flags & O_NONBLOCK)) {
 		res = wait_event_interruptible_locked_irq(ctx->wqh,
-				ULLONG_MAX - ctx->count > ucnt);
+				eventfd_is_writable(ctx, ucnt));
 		if (!res)
 			res = sizeof(ucnt);
 	}
@@ -283,22 +290,62 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct eventfd_ctx *ctx = f->private_data;
-	__u64 cnt;
+	__u64 cnt, max;
 
 	spin_lock_irq(&ctx->wqh.lock);
 	cnt = ctx->count;
+	max = ctx->maximum;
 	spin_unlock_irq(&ctx->wqh.lock);
 
 	seq_printf(m,
 		   "eventfd-count: %16llx\n"
 		   "eventfd-id: %d\n"
-		   "eventfd-semaphore: %d\n",
+		   "eventfd-semaphore: %d\n"
+		   "eventfd-maximum: %16llx\n",
 		   cnt,
 		   ctx->id,
-		   !!(ctx->flags & EFD_SEMAPHORE));
+		   !!(ctx->flags & EFD_SEMAPHORE),
+		   max);
 }
 #endif
 
+static long eventfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct eventfd_ctx *ctx = file->private_data;
+	void __user *argp = (void __user *)arg;
+	__u64 max;
+	int ret;
+
+	switch (cmd) {
+	case EFD_IOC_SET_MAXIMUM:
+		if (copy_from_user(&max, argp, sizeof(max)))
+			return -EFAULT;
+
+		spin_lock_irq(&ctx->wqh.lock);
+		if (ctx->count >= max) {
+			ret = -EINVAL;
+		} else {
+			ctx->maximum = max;
+			ret = 0;
+			/* wake blocked writers that may now fit within the new maximum */
+			if (waitqueue_active(&ctx->wqh))
+				wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
+		}
+		spin_unlock_irq(&ctx->wqh.lock);
+		return ret;
+
+	case EFD_IOC_GET_MAXIMUM:
+		spin_lock_irq(&ctx->wqh.lock);
+		max = ctx->maximum;
+		spin_unlock_irq(&ctx->wqh.lock);
+
+		return copy_to_user(argp, &max, sizeof(max)) ? -EFAULT : 0;
+
+	default:
+		return -ENOTTY;
+	}
+}
+
 static const struct file_operations eventfd_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= eventfd_show_fdinfo,
@@ -307,6 +354,8 @@ static const struct file_operations eventfd_fops = {
 	.poll		= eventfd_poll,
 	.read_iter	= eventfd_read,
 	.write		= eventfd_write,
+	.unlocked_ioctl	= eventfd_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= noop_llseek,
 };
 
@@ -395,6 +444,7 @@ static int do_eventfd(unsigned int count, int flags)
 	kref_init(&ctx->kref);
 	init_waitqueue_head(&ctx->wqh);
 	ctx->count = count;
+	ctx->maximum = ULLONG_MAX;
 	ctx->flags = flags;
 
 	flags &= EFD_SHARED_FCNTL_FLAGS;
diff --git a/include/uapi/linux/eventfd.h b/include/uapi/linux/eventfd.h
index 2eb9ab6c32f3..ba46b746f597 100644
--- a/include/uapi/linux/eventfd.h
+++ b/include/uapi/linux/eventfd.h
@@ -3,9 +3,15 @@
 #define _UAPI_LINUX_EVENTFD_H
 
 #include <linux/fcntl.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define EFD_SEMAPHORE (1 << 0)
 #define EFD_CLOEXEC O_CLOEXEC
 #define EFD_NONBLOCK O_NONBLOCK
 
+/* Flow-control ioctls: configure the per-fd counter maximum. */
+#define EFD_IOC_SET_MAXIMUM	_IOW('J', 0, __u64)
+#define EFD_IOC_GET_MAXIMUM	_IOR('J', 1, __u64)
+
 #endif /* _UAPI_LINUX_EVENTFD_H */
-- 
2.25.1

