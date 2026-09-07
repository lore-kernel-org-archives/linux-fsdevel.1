Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8295474E
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778844; cv=pass; b=Jvmx4d1FbhnSoLRpFrd9pb+fi3I9budFtDQ3v0OlWTzmjlEu8qdB9pdMs58fDu9StIZl+nd9NJgTn2pEdB8BiNJnSLXMt9SOYqKTA7+zy6SXIEwzDa8OSOiwnht/Pvyq0DHi+FMnJcYDCweP9cdPHK+Mq7tg6xoJujVv6PpcP1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778844; c=relaxed/simple;
	bh=1W8uvQaYp8lzNksLgoSJuXrmpDkGKXa2H0+Uugp+NpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebuhW3a+v5+/MSklwKpTES95wOQTRxp4W7dAN7QtLIglXLplXpgBx386WUjwMTbUga5/9HEiloLNCvjd+XvIrD295V7QjOjRE2x+3i/4Z1Ch0ed4nGbddvnnuQtIEljI9vbGmAoFrF4XRrImQ1vYkOsqVCV3COIyOyy7Fa5/jls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=fes6b/oi; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="fes6b/oi"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c25420fe973so561400066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 04:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788778840; cv=none;
        d=google.com; s=arc-20260327;
        b=P12WGwS4H55lgKzjDL6052kogzqTnm5/N5ZF7/RiaVElgw4El2gY+w/jZc6CHABEKV
         8oS4JUl64YG20vto1HOxWUmpugjJyfJYm6qJNN/3PByYzdyvSFeiD8nJIpzxAuIvPjpp
         +zecUFmKqr1B8fg+WdvTr41VuOyi+60yMvG2oMWFYPY64pBI0YrH2fLPJEMRiwkrhh5T
         9Ga5Hhz7lSBut3asVj7KeM9hkTeII3lUoueN2JAx4hApjsbAfBrdqXJZOyuzRFFvVJ/C
         6Nyc7TM/FokGhNQlF6SFyzRsHv8m7ankZxHNcvlCC4pLrr05S27yB7CoRs/ajMTfGcDQ
         IhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zny1KKC/uPX8QbOxaFwPCGHoxMxtpzdiurM7Tl80u1k=;
        fh=o1XSKrmCgLjDWR9nxlEOHwedIR1oQFvTlC0OZrnCi/A=;
        b=LzThXnmXoztZ16xpmmQQzB9VfGQg4ynS1FsHakxvDj8Bj7ZpfRZh4UCGnizmIdi7JR
         husYe9LGQkOMffz6MZHj+pIbITQAsvOmQzNx0ZB11vqkmD6x68ureLDIki53mkewqqAe
         BmNEs5kE0nppRe3HY16VeF2keFBBOfKwTIMjhuwTIvXkburTV6fPFuwEPzX0ozJtSkwo
         NUxAVRz3AxgXXexUhjona9kUfMs4SE9s9YeBj/aZG7Z7Nb2R5Yc1UdjBPMCpn59lze16
         nTDrsfgYnCFIAWg4680SuQe2ed8HPSauKuHWcO650WeUToLCxl0VWmmxj0aW0H7ya4qA
         C92w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788778840; x=1789383640; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zny1KKC/uPX8QbOxaFwPCGHoxMxtpzdiurM7Tl80u1k=;
        b=fes6b/oi9GNDqVkNavvFasu3Ix6qQF3e72pzkNmozFR13Q4JgFNWmijgUukPPBkTRz
         mQrEGCxy9QYh7qe6aHOtf/mUPiy5NppxysGh2K8i+hcWhce/GGL+YPL6SRJThSmwFrZO
         78adGg/qgqERyN5scyWvT8eWFwajNMyDJe+t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778840; x=1789383640;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zny1KKC/uPX8QbOxaFwPCGHoxMxtpzdiurM7Tl80u1k=;
        b=l+BfoO7gNurrSp11Eitt9bFWacWI1aJKumUOhBAWvyjrNzyJs2ybh7db+G3dwfBstq
         ZdYZBsPGUNHONj1mAW8aIDS3jb9ZfsVOeTLiWnyPXMXsSWF/z+fABrnqvCbX+oNV2FUD
         /4YISw/pBDBZQy9jYDUW99kX5S8JChgos/PsIngrSAl2wHSRrv3yJf2t07iQlktSTSxu
         Hk9WhrGOajswP/z3hRAi8lC/sYi+wX5HEsJCOYlj5j3sZKh0kG1IfzZ6+/ywFSqoPeij
         qY/B2gwxpV8y4Gvi9nCK+A6A11MEFKBkEVuhk6FMqUSucoA0xrBNg7DFFK+FXpzZfB+c
         CLRA==
X-Forwarded-Encrypted: i=1; AKwUvBz+ygtxl5FpihZvdnOrPdbFU8CQTrNQ+nsaPlM2UTujK0Qcr9KIE3GsCRkDCHjR/thgLs+NofXc/I1vDSli@vger.kernel.org
X-Gm-Message-State: AFuF++m5pEoM8C09Bgj8v47+rUij8MJNLfrCEsgqn3Q5i/Di3phW+zz/
	qj6eJt7QU6ycfXoUHR8eNXsxtIOtcs7AgTMNNmZXZsvwQyN5mLMo+N1vmYLs1DH2JdEy3DALiwW
	jliQklPv9DTjWu0JobhABkCsVfdWqBeoWTqbH1Y11tg==
X-Gm-Gg: AYBFou1M1PNr6z/aUTx29fr2M72bz2HCwhBsOa46va3yco9PrN1F/M5EZdlEEJBxIhm
	hZMKykhwZ2VNaFEZtXDBfzHLy9mvKp/EnqUYqLh4yGcVg9fddvvfio/ZUAKesGfPS1t/xfUp2NQ
	JYUX1G4wu21NC2iMLtcgEI5hop2PUCJE0J+PCgwug9WsV6qEq5vn80xKhDuOjM9tNYEaTg/wBfM
	ZddsBkgQ5BSlMSMIgT1nwz1BaF3MnK2GFYTga7NrmiSSrpemTt9fNwUDoEBqFdJF5xeb06UkEuN
	tiFETsWFl/FWnIKcyOq9qVIsQMKHzF5mYUpAdMptAt7wesjHJoxP9ym8o9bd+DcD1j/AcDtIKQY
	=
X-Received: by 2002:a17:907:7294:b0:c26:19de:9139 with SMTP id
 a640c23a62f3a-c2619dea0f1mr752175766b.44.1788778839290; Mon, 07 Sep 2026
 04:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-10-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-10-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 13:00:27 +0200
X-Gm-Features: AcwNN1U23yfZ1nAFBhZtDhOey9YcEzK38gF_zORjIDm7e-DTOat32VqriNkwZBM
Message-ID: <CAJqdLrpDz4DAkoK-5+s-KmafRsudctd3OouhXmgV=nNM-Up72w@mail.gmail.com>
Subject: Re: [PATCH 10/10] selftests/coredump: check the dumping thread's pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 31. Aug. 2026 um 13:22 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Crash from a non-leader thread and verify that the pidfd from
> SO_PEERPIDFD_THREAD on the coredump socket refers to that thread and
> reports the coredump like the thread-group leader's pidfd does.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  .../selftests/coredump/coredump_socket_test.c      | 175 +++++++++++++++++++++
>  tools/testing/selftests/coredump/coredump_test.h   |   2 +
>  .../selftests/coredump/coredump_test_helpers.c     |  49 ++++++
>  3 files changed, 226 insertions(+)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index 422728f632ca..ec73bb690bbc 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -592,6 +592,181 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
>         wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
>  }
>
> +static bool check_coredump_info(const struct pidfd_info *info, const char *what)
> +{
> +       if (!(info->mask & PIDFD_INFO_COREDUMP)) {
> +               fprintf(stderr, "%s: PIDFD_INFO_COREDUMP not set in mask\n", what);
> +               return false;
> +       }
> +
> +       if (!(info->coredump_mask & PIDFD_COREDUMPED)) {
> +               fprintf(stderr, "%s: PIDFD_COREDUMPED not set in coredump_mask\n", what);
> +               return false;
> +       }
> +
> +       if (!(info->mask & PIDFD_INFO_COREDUMP_SIGNAL) || info->coredump_signal != SIGSEGV) {
> +               fprintf(stderr, "%s: coredump_signal=%d, expected SIGSEGV=%d\n",
> +                       what, info->coredump_signal, SIGSEGV);
> +               return false;
> +       }
> +
> +       if (!(info->mask & PIDFD_INFO_COREDUMP_CODE) || info->coredump_code != SEGV_MAPERR) {
> +               fprintf(stderr, "%s: coredump_code=%d, expected SEGV_MAPERR=%d\n",
> +                       what, info->coredump_code, SEGV_MAPERR);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +/*
> + * Test: PIDFD_INFO_COREDUMP on the dumping thread's pidfd
> + *
> + * Crash from a non-leader thread and verify that the pidfd from
> + * SO_PEERPIDFD_THREAD refers to that thread and reports the coredump
> + * like the thread-group leader's pidfd from SO_PEERPIDFD does.
> + */
> +TEST_F(coredump, socket_coredump_thread)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
> +               int fd_thread_pidfd = -1, fd_core_file = -1;
> +               struct pidfd_info thread_info = {};
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: listen socket failed: %m\n");
> +                       goto out;
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: ipc write failed: %m\n");
> +                       goto out;
> +               }
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: accept4 failed: %m\n");
> +                       goto out;
> +               }
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: get_peer_pidfd failed\n");
> +                       goto out;
> +               }
> +
> +               fd_thread_pidfd = get_peer_pidfd_thread(fd_coredump);
> +               if (fd_thread_pidfd < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: get_peer_pidfd_thread failed\n");
> +                       goto out;
> +               }
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info) ||
> +                   !get_pidfd_info(fd_thread_pidfd, &thread_info)) {
> +                       fprintf(stderr, "socket_coredump_thread: get_pidfd_info failed\n");
> +                       goto out;
> +               }
> +
> +               /* The peer is the thread-group leader, the dumping thread is not. */
> +               if (info.pid != info.tgid || thread_info.tgid != info.tgid ||
> +                   thread_info.pid == thread_info.tgid) {
> +                       fprintf(stderr, "socket_coredump_thread: unexpected ids %d/%d and %d/%d\n",
> +                               info.pid, info.tgid, thread_info.pid, thread_info.tgid);
> +                       goto out;
> +               }
> +
> +               if (!check_coredump_info(&info, "SO_PEERPIDFD") ||
> +                   !check_coredump_info(&thread_info, "SO_PEERPIDFD_THREAD"))
> +                       goto out;
> +
> +               fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: core tmpfile failed: %m\n");
> +                       goto out;
> +               }
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read, bytes_write;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read < 0) {
> +                               fprintf(stderr, "socket_coredump_thread: core read failed: %m\n");
> +                               goto out;
> +                       }
> +
> +                       if (bytes_read == 0)
> +                               break;
> +
> +                       bytes_write = write(fd_core_file, buffer, bytes_read);
> +                       if (bytes_read != bytes_write) {
> +                               fprintf(stderr, "socket_coredump_thread: core write %zd/%zd: %m\n",
> +                                       bytes_read, bytes_write);
> +                               goto out;
> +                       }
> +               }
> +
> +               exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_coredump_thread: completed successfully\n");
> +out:
> +               if (fd_core_file >= 0)
> +                       close(fd_core_file);
> +               if (fd_thread_pidfd >= 0)
> +                       close(fd_thread_pidfd);
> +               if (fd_peer_pidfd >= 0)
> +                       close(fd_peer_pidfd);
> +               if (fd_coredump >= 0)
> +                       close(fd_coredump);
> +               if (fd_server >= 0)
> +                       close(fd_server);
> +               _exit(exit_code);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0)
> +               crashing_child_thread();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_EQ(WTERMSIG(status), SIGSEGV);
> +       ASSERT_TRUE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
> +       ASSERT_TRUE(!!(info.coredump_mask & PIDFD_COREDUMPED));
> +       ASSERT_EQ(info.coredump_signal, SIGSEGV);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
>  /*
>   * Test: PIDFD_INFO_COREDUMP_SIGNAL via simple socket coredump with SIGABRT
>   *
> diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
> index ed47f01fa53c..4212656e31f0 100644
> --- a/tools/testing/selftests/coredump/coredump_test.h
> +++ b/tools/testing/selftests/coredump/coredump_test.h
> @@ -27,10 +27,12 @@ FIXTURE(coredump)
>  /* Shared helper function declarations */
>  void *do_nothing(void *arg);
>  void crashing_child(void);
> +void crashing_child_thread(void);
>  int create_detached_tmpfs(void);
>  int create_and_listen_unix_socket(const char *path);
>  bool set_core_pattern(const char *pattern);
>  int get_peer_pidfd(int fd);
> +int get_peer_pidfd_thread(int fd);
>  bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
>
>  /* Inline helper that uses harness types */
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 2a20faf9cb0a..36306069f62e 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -13,6 +13,7 @@
>  #include <string.h>
>  #include <sys/epoll.h>
>  #include <sys/ioctl.h>
> +#include <sys/mman.h>
>  #include <sys/socket.h>
>  #include <sys/types.h>
>  #include <sys/un.h>
> @@ -38,6 +39,10 @@ struct _fixture_coredump_data {
>
>  #define NUM_THREAD_SPAWN 128
>
> +#ifndef SO_PEERPIDFD_THREAD
> +#define SO_PEERPIDFD_THREAD 87
> +#endif
> +
>  void *do_nothing(void *arg)
>  {
>         (void)arg;
> @@ -59,6 +64,36 @@ void crashing_child(void)
>         i = *(volatile int *)NULL;
>  }
>
> +static void *crashing_thread(void *arg)
> +{
> +       int *p;
> +
> +       (void)arg;
> +
> +       /* crash on purpose with SEGV_MAPERR */
> +       p = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (p == MAP_FAILED)
> +               return NULL;
> +       munmap(p, PAGE_SIZE);
> +       *p = 0;
> +
> +       return NULL;
> +}
> +
> +void crashing_child_thread(void)
> +{
> +       pthread_t thread;
> +       int i;
> +
> +       for (i = 0; i < NUM_THREAD_SPAWN; ++i)
> +               pthread_create(&thread, NULL, do_nothing, NULL);
> +
> +       /* crash from a non-leader thread */
> +       pthread_create(&thread, NULL, crashing_thread, NULL);
> +       pause();
> +}
> +
>  int create_detached_tmpfs(void)
>  {
>         int fd_context, fd_tmpfs;
> @@ -138,6 +173,20 @@ int get_peer_pidfd(int fd)
>         return fd_peer_pidfd;
>  }
>
> +int get_peer_pidfd_thread(int fd)
> +{
> +       int fd_peer_pidfd;
> +       socklen_t fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
> +       int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD_THREAD, &fd_peer_pidfd,
> +                            &fd_peer_pidfd_len);
> +       if (ret < 0) {
> +               fprintf(stderr, "%s: getsockopt(SO_PEERPIDFD_THREAD) failed: %m\n", __func__);
> +               return -1;
> +       }
> +       fprintf(stderr, "%s: successfully retrieved pidfd %d\n", __func__, fd_peer_pidfd);
> +       return fd_peer_pidfd;
> +}
> +
>  bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
>  {
>         int ret;
>
> --
> 2.53.0
>
