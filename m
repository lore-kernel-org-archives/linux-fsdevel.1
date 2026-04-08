Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328393D7D75;
	Wed,  8 Apr 2026 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669135; cv=none; b=N8D+4krblPoa+OoEpkZr94yKfsPXggMvAirXbqWdmViIPC439OUMKWwe0kPxmjZdkcctlHVMU+OG8Y0YfbUZQfHQshkJZzWQcQakQqq/ISGOQmSsh6mLaSwTCaRQ7xujR0nRf6AvBC6twVoH/LSLGjFax19GeNKPv72YfNEgGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669135; c=relaxed/simple;
	bh=eBMOIfYkZSjmKX09Qny+B41bP+n6c8P5iR1PGnajsZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbgMBeHxHNLtkDS3mNsEsrVSVDbADLXhyayXX2w0pZEsKrRq9oh7bC/Z/SU/w8v0dZCWTijB884ASNCQwIZrD4WPXqeMYHgfz6xrXf/6xSGCXIYW/F5QmyHkNUbzRF2kHBZVHI8aKSqbGR1pxQDEBrkO7HHhnQzi37eVXIkLrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ElVfCR+Y; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ElVfCR+Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775669130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfOVlvYe3DzzLYGaVKTGmYsApwZhw34DllCA7bYlkW4=;
	b=ElVfCR+Y4cwEiqW8LnT2Ka8dX35hxyfM+ZWjT3ExOi3YlGv0BHS0cQZiOXJwsheSOrdSLG
	ryKhJk9U2t+gVvkLoZky1zbNqyHrYHMTB0I10cYfcX6ZiuojJXsVPKosXmso6b9FtQPJ7p
	uUfpVQskTuy/dBsHW8rm2ct3oN/sbLI=
From: wen.yang@linux.dev
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v5 2/2] selftests/eventfd: add EFD_IOC_{SET,GET}_MAXIMUM tests
Date: Thu,  9 Apr 2026 01:24:49 +0800
Message-Id: <183b5d6987f8a23b5912c3f8a8e618ef70f2fbd4.1775668339.git.wen.yang@linux.dev>
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

Add correctness tests for the flow-control ioctls introduced in the
preceding commit.  Cover the GET/SET round-trip, EINVAL when the
requested maximum does not exceed the current counter, EAGAIN on an
O_NONBLOCK fd when a write would reach the configured maximum, EPOLLOUT
gating at maximum-1, /proc/self/fdinfo exposure of the "eventfd-maximum"
field, and ENOTTY for unrecognised ioctl commands.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../filesystems/eventfd/eventfd_test.c        | 238 +++++++++++++++++-
 1 file changed, 237 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
index 1b48f267157d..9e33780f5330 100644
--- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
+++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
@@ -5,12 +5,22 @@
 #include <fcntl.h>
 #include <asm/unistd.h>
 #include <linux/time_types.h>
+#include <stdarg.h>
+#include <stdint.h>
+#include <string.h>
 #include <unistd.h>
 #include <assert.h>
 #include <signal.h>
 #include <pthread.h>
 #include <sys/epoll.h>
-#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+/*
+ * Prevent <asm-generic/fcntl.h> (pulled in via <linux/eventfd.h> ->
+ * <linux/fcntl.h> -> <asm/fcntl.h>) from redefining struct flock and
+ * friends that are already provided by the system <fcntl.h> above.
+ */
+#define _ASM_GENERIC_FCNTL_H
+#include <linux/eventfd.h>
 #include "kselftest_harness.h"
 
 #define EVENTFD_TEST_ITERATIONS 100000UL
@@ -308,4 +318,230 @@ TEST(eventfd_check_read_with_semaphore)
 	close(fd);
 }
 
+/*
+ * The default maximum is ULLONG_MAX, matching the original behaviour.
+ */
+TEST(eventfd_check_ioctl_get_maximum_default)
+{
+	uint64_t max;
+	int fd, ret;
+
+	fd = sys_eventfd2(0, EFD_NONBLOCK);
+	ASSERT_GE(fd, 0);
+
+	ret = ioctl(fd, EFD_IOC_GET_MAXIMUM, &max);
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(max, UINT64_MAX);
+
+	close(fd);
+}
+
+/*
+ * EFD_IOC_SET_MAXIMUM and EFD_IOC_GET_MAXIMUM round-trip.
+ */
+TEST(eventfd_check_ioctl_set_get_maximum)
+{
+	uint64_t max;
+	int fd, ret;
+
+	fd = sys_eventfd2(0, EFD_NONBLOCK);
+	ASSERT_GE(fd, 0);
+
+	max = 1000;
+	ret = ioctl(fd, EFD_IOC_SET_MAXIMUM, &max);
+	EXPECT_EQ(ret, 0);
+
+	max = 0;
+	ret = ioctl(fd, EFD_IOC_GET_MAXIMUM, &max);
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(max, 1000);
+
+	close(fd);
+}
+
+/*
+ * Setting a maximum that is less than or equal to the current counter
+ * must fail with EINVAL.
+ */
+TEST(eventfd_check_ioctl_set_maximum_invalid)
+{
+	uint64_t value = 5, max;
+	ssize_t size;
+	int fd, ret;
+
+	fd = sys_eventfd2(0, EFD_NONBLOCK);
+	ASSERT_GE(fd, 0);
+
+	/* write 5 into the counter */
+	size = write(fd, &value, sizeof(value));
+	EXPECT_EQ(size, (ssize_t)sizeof(value));
+
+	/* setting maximum == count (5) must fail */
+	max = 5;
+	ret = ioctl(fd, EFD_IOC_SET_MAXIMUM, &max);
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* setting maximum < count (3 < 5) must also fail */
+	max = 3;
+	ret = ioctl(fd, EFD_IOC_SET_MAXIMUM, &max);
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* setting maximum > count (10 > 5) must succeed */
+	max = 10;
+	ret = ioctl(fd, EFD_IOC_SET_MAXIMUM, &max);
+	EXPECT_EQ(ret, 0);
+
+	close(fd);
+}
+
+/*
+ * Writes that would push the counter to or beyond maximum must return
+ * EAGAIN on a non-blocking fd.  After a read drains the counter the
+ * write should succeed again.
+ */
+TEST(eventfd_check_ioctl_write_blocked_at_maximum)
+{
+	uint64_t value, max_val = 5;
+	ssize_t size;
+	int fd, ret;
+
+	fd = sys_eventfd2(0, EFD_NONBLOCK);
+	ASSERT_GE(fd, 0);
+
+	ret = ioctl(fd, EFD_IOC_SET_MAXIMUM, &max_val);
+	ASSERT_EQ(ret, 0);
+
+	/* write 4 — counter becomes 4, one slot before maximum */
+	value = 4;
+	size = write(fd, &value, sizeof(value));
+	EXPECT_EQ(size, (ssize_t)sizeof(value));
+
+	/*
+	 * Writing 1 more would reach maximum (4+1 == 5 == maximum), which
+	 * is the overflow level.  The write must block, i.e. return EAGAIN
+	 * in non-blocking mode.
+	 */
+	value = 1;
+	size = write(fd, &value, sizeof(value));
+	EXPECT_EQ(size, -1);
+	EXPECT_EQ(errno, EAGAIN);
+
+	/* drain the counter */
+	size = read(fd, &value, sizeof(value));
+	EXPECT_EQ(size, (ssize_t)sizeof(value));
+	EXPECT_EQ(value, 4);
+
+	/* now the write must succeed (counter was reset to 0) */
+	value = 1;
+	size = write(fd, &value, sizeof(value));
+	EXPECT_EQ(size, (ssize_t)sizeof(value));
+
+	close(fd);
+}
+
+/*
+ * Verify that EPOLLOUT is correctly gated by the configured maximum:
+ * it should be clear when count >= maximum - 1, and set again after a read.
+ */
+TEST(eventfd_check_ioctl_poll_epollout)
+{
+	struct epoll_event ev, events[2];
+	uint64_t value, max_val = 5;
+	ssize_t sz;
+	int fd, epfd, nfds, ret;
+
+	fd = sys_eventfd2(0, EFD_NONBLOCK);
+	ASSERT_GE(fd, 0);
+
+	epfd = epoll_create1(0);
+	ASSERT_GE(epfd, 0);
+
+	ev.events = EPOLLIN | EPOLLOUT | EPOLLERR;
+	ev.data.fd = fd;
+	ret = epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev);
+	ASSERT_EQ(ret, 0);
+
+	ret = ioctl(fd, EFD_IOC_SET_MAXIMUM, &max_val);
+	ASSERT_EQ(ret, 0);
+
+	/* fresh fd: EPOLLOUT must be set (count=0 < maximum-1=4) */
+	nfds = epoll_wait(epfd, events, 2, 0);
+	EXPECT_EQ(nfds, 1);
+	EXPECT_TRUE(!!(events[0].events & EPOLLOUT));
+
+	/* write 4 — count reaches maximum-1=4, EPOLLOUT must clear */
+	value = 4;
+	sz = write(fd, &value, sizeof(value));
+	EXPECT_EQ(sz, (ssize_t)sizeof(value));
+
+	nfds = epoll_wait(epfd, events, 2, 0);
+	EXPECT_EQ(nfds, 1);
+	EXPECT_FALSE(!!(events[0].events & EPOLLOUT));
+	EXPECT_TRUE(!!(events[0].events & EPOLLIN));
+
+	/* drain counter — EPOLLOUT must reappear */
+	sz = read(fd, &value, sizeof(value));
+	EXPECT_EQ(sz, (ssize_t)sizeof(value));
+
+	nfds = epoll_wait(epfd, events, 2, 0);
+	EXPECT_EQ(nfds, 1);
+	EXPECT_TRUE(!!(events[0].events & EPOLLOUT));
+
+	close(epfd);
+	close(fd);
+}
+
+/*
+ * /proc/self/fdinfo must expose the configured maximum.
+ */
+TEST(eventfd_check_fdinfo_maximum)
+{
+	struct error err = {0};
+	uint64_t max_val = 12345;
+	int fd, ret;
+
+	fd = sys_eventfd2(0, 0);
+	ASSERT_GE(fd, 0);
+
+	/* before setting: default should be ULLONG_MAX */
+	ret = verify_fdinfo(fd, &err, "eventfd-maximum: ", 17,
+			    "%16llx\n", (unsigned long long)UINT64_MAX);
+	if (ret != 0)
+		ksft_print_msg("eventfd-maximum default check failed: %s\n",
+			       err.msg);
+	EXPECT_EQ(ret, 0);
+
+	ret = ioctl(fd, EFD_IOC_SET_MAXIMUM, &max_val);
+	ASSERT_EQ(ret, 0);
+
+	memset(&err, 0, sizeof(err));
+	ret = verify_fdinfo(fd, &err, "eventfd-maximum: ", 17,
+			    "%16llx\n", (unsigned long long)max_val);
+	if (ret != 0)
+		ksft_print_msg("eventfd-maximum after set check failed: %s\n",
+			       err.msg);
+	EXPECT_EQ(ret, 0);
+
+	close(fd);
+}
+
+/*
+ * An unrecognised ioctl must return ENOTTY (not EINVAL or ENOENT).
+ */
+TEST(eventfd_check_ioctl_unknown)
+{
+	int fd, ret;
+
+	fd = sys_eventfd2(0, 0);
+	ASSERT_GE(fd, 0);
+
+	ret = ioctl(fd, _IO('J', 0xff));
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno, ENOTTY);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.25.1

