Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F2468C24
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864431; cv=pass; b=Vipk462sGj1PJqpAcsBJhd13iOXPJbQMD0Uo4qyOkx+zQYttjOFLmaPvzhobzDwl+Xn/Ls7Xk92By6ZIKZ0j58VparUS+UfGd0TUy36MYVA0MxeOvV+h5llbhv4rDc02FlCAov5bBrud8YuGrPoE8nr6inS/2YkgBDPvU38uqfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864431; c=relaxed/simple;
	bh=RMMmeLdwkKkn4BEDDp1e7e2IsCudV2cPJHr6UYvPY64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quEU+jjEnndYorXKNpK+zcdu+L4L8Tt39OwsmUXZWcPxPmW5h1rek+hE4WZvDmkQkRmyXQRX+BsuhL3iGGBKUEWHcIrWO3jEmxCt+nW7uCCvu1jyFhx4wz5A/eNW0wfrjqUsvB4FKVz5IRyhYRsRHL6tc9q8/UZbgHpvhQqXNCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDe3TB+J; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDe3TB+J"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c96c92c0980so2161a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 10:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785864429; cv=none;
        d=google.com; s=arc-20260327;
        b=spkJAeJp7U3AcbkquBCVdVk8QEZnhcskjguSVsIL0Y1MRwlczcPIZkoYjtphSV37p7
         v9EQpk10ywAe3jRZOdzHoJ+v4T6H9ALkxyzKppUXWkGsamlurzd6q8+PQJ6EU11lK0Nb
         OKtwK1UjV52YAX0neozzBQQ1B8a3UmPOVg6CU9zH/sA5AD3nCPZWVuy9RU3x+HRPen2l
         JqhYhbOKvc0TpEMZTe4ZPrcKcgPEIVbsi5q7NXIGnOHS6NrBTOmPdoBa1HheL+Op9JwL
         5yGdNunE5aTqXJK5J4MIz2DVIqlzQh8rfy5b5OLVxLqlNXbZOwXqiux6u6RIQi5GzRcL
         capA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=abkOpCT8XDHQXudW2+7qetKr9+yD5aJlgCU2le2Y25I=;
        fh=xm1xkWsd4H0azVqrrW5x0WN+wDLGstpDs+0UVB/Uhug=;
        b=VemmR7Ez39ewlgg3hpSuy4vR/51vwPQJU/nStDPlc7mS1ziMJfzLu9wObACTaA6g9p
         O9Z6Db9SFmmaKhCQv0zAdAtp6maWVtbznivNVJOHPnmPHp4KNABR2DjcAL9YUWAxLz6V
         nUDr+m17GVayxaC158NHfyQP5e0EfFdPq2DFXQ6Z8tsbDKbaxg8IuKw6mRxCg3PCD7VN
         cxKy/TMONpFsElWcHpK9BL5PyBcuhP584KffEo1VF1kXEEL81S5usoGf+DjFfkKoy/VD
         UhPiLONdNxqyFJPT+JdeQjYMpanivj3fG6WS/aA5tYPYrOm4aQah6WqMQYxNXmE1vRiX
         kh5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785864429; x=1786469229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=abkOpCT8XDHQXudW2+7qetKr9+yD5aJlgCU2le2Y25I=;
        b=pDe3TB+JsDZFryrI7mj3zrzm8094gYlA0c55hA7weu6wogXjSP3jcN9bIgGHdYqSO7
         V8CnongtmxCagRrNW+i5DKWgfMHTiLUghs+AI350+WE28Ppv9l5kpcmw1gC45dkztT9w
         80h+RObGEMEg2bm2Y797K++htyjUn5o1DMP2C+vM3PXO490XlcOl5bVPC6TgnXIGRnYX
         I5PHd0cqTjq9796hZY3ZKISyeZv2rkFB1dVI5vgiFS06kzR89OMRSz6BUc/6WBIbOBSc
         t7oVfnB33CP9RZ99l9U7tbwST3/kTIFYJdcW801gGF9nimB/5sK3NUWhZkM4jJQJOs97
         t9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864429; x=1786469229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=abkOpCT8XDHQXudW2+7qetKr9+yD5aJlgCU2le2Y25I=;
        b=Q8NOeP4Re58V5yrkX1e/a0GUaKcF7OPVIYr4vpu9KmvgWF8oJH3U+xiFa1kokyar+o
         YZLsPeboGABjWnegkK+H2NJhYnyQCzeASyZYWq5aDSN8vMdoK9zrnI2DOv1BywC38IVA
         pMGVUamhNyHHRJMmqK4VzKaAZqc/w4L/Y60FoIOTR9+teDblIavWbcX8KCUtehtoanFv
         99kN/fzDpuYO/pJGjYXsUjI5JZGB6TSwoGJcXcDVO4vgS9dxCAcWuNrTezVKqApkyiHd
         0E/UxSZTjrHt42EdFZu5FY8dVyPg/K36GOlGCmdLZT7sjAXkWD+GSz4pHwCXvOahEWjV
         GMOg==
X-Forwarded-Encrypted: i=1; AHgh+RqyFXB2lnQr/Vpi0bw7q2vSH64Lf0sIJzps/14CMbvMvTFP0+2K2D8XfsKqURGDy2UtJjewtCcV44Y/R+G0@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQnsLCPItW/wt9AJmhdGCXLtjSf+13afLua2prNLb1b6xbWH1
	ocex6LmQ6XsWJ7jwb9KQbAYRZPJoiIoMjQSFrbR+dPf8qDj/Xia0IFh/b6s1H6esPXXwDYiha6A
	PQE2YFPEO8ZGA7tOPQ786TpWUu3qZnDaN58/vH9N+
X-Gm-Gg: AR+sD13G9R4ho5P7ngG7EKLhkLSrhzCI/sHgNoLcEtkidTD81pierRXSYKqDZ4W02Gk
	tpiQJLiNIL39lyC0qDb7y04p6L3EuocrYUuY0qsIGOfR89HQIhe6YF8ataUY7EoeYUcUSjF/WXC
	4jTh3SHNmrOHSii+JNbzQ7fEKcSASjEQDp/sotvX9CBSprVl1R8CZiAgoltGbXrHI3+WyX3KPuH
	XlTTBNmTgPyPCrXCjgB1zewIT//zhN2u+aeoglPc337qzN08DMPT0ldSs3QHtLoUJtp+wJRqJ2D
	/KqlsLFyU37wo1oaKkaJfQ+sIPKyeaUJVljYdS1Srx5tjf6yY6WQs3AyEmRln6pzzb98F2qHarI
	/f7ZbkWOycyFrIy4HO3NaJW8JUp4pB4tIczj9J450btpCKX9YcAcnZ/73LObfUVFph5ro9EP5aH
	UjI7pgPsjHASs=
X-Received: by 2002:a05:6a20:d52a:b0:3b4:5ff3:45cb with SMTP id
 adf61e73a8af0-3cb85df276cmr528914637.8.1785864428579; Tue, 04 Aug 2026
 10:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl> <20260802151212.3294591-5-jkoolstra@xs4all.nl>
In-Reply-To: <20260802151212.3294591-5-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 10:26:57 -0700
X-Gm-Features: AUfX_mzydG819L_W9EPqXxJoJr-EzFjcatDcSfIvO9Eo6TPJdK36l68WshrAXEw
Message-ID: <CAAVpQUC7O1yiKQ+3FcGWbDkmcd-LeFc5tCC0vF7QgioVOXvb5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/4] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:11=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
> Tests SCM_RIGHTS fd passing on a socket with the new socket option
> SO_RIGHTS_NOTRUNC turned on. To hook into the security_file_receive()
> call, BPF is used. The BPF program shares a hashmap with userspace that
> lists the inos to be blocked (of the receiver tgid).
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  .../testing/selftests/net/af_unix/.gitignore  |   2 +
>  tools/testing/selftests/net/af_unix/Makefile  |   8 +
>  tools/testing/selftests/net/af_unix/config    |   7 +
>  .../net/af_unix/scm_rights_denial_lsm.bpf.c   |  36 +++
>  .../net/af_unix/scm_rights_denial_lsm.c       | 285 ++++++++++++++++++
>  5 files changed, 338 insertions(+)
>  create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial=
_lsm.bpf.c
>  create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial=
_lsm.c
>
> diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testi=
ng/selftests/net/af_unix/.gitignore
> index 973176644103..954f0958dd03 100644
> --- a/tools/testing/selftests/net/af_unix/.gitignore
> +++ b/tools/testing/selftests/net/af_unix/.gitignore
> @@ -3,6 +3,8 @@ msg_oob
>  scm_inq
>  scm_pidfd
>  scm_rights
> +scm_rights_denial_lsm
> +scm_rights_denial_lsm.bpf.o
>  so_peek_off
>  unix_connect
>  unix_connreset
> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing=
/selftests/net/af_unix/Makefile
> index 57d159803a3a..a66f10fb0c23 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -11,10 +11,18 @@ TEST_GEN_PROGS :=3D \
>         scm_inq \
>         scm_pidfd \
>         scm_rights \
> +       scm_rights_denial_lsm \
>         so_peek_off \
>         unix_connect \
>         unix_connreset \
>         unix_listen \
>  # end of TEST_GEN_PROGS
>
> +TEST_GEN_FILES :=3D scm_rights_denial_lsm.bpf.o
> +
>  include ../../lib.mk
> +include ../bpf.mk
> +
> +$(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
> +$(OUTPUT)/scm_rights_denial_lsm: CFLAGS +=3D -I$(SCRATCH_DIR)/include
> +$(OUTPUT)/scm_rights_denial_lsm: LDLIBS +=3D -lelf -lz
> diff --git a/tools/testing/selftests/net/af_unix/config b/tools/testing/s=
elftests/net/af_unix/config
> index 41dbb03c747e..468f7a0bb64e 100644
> --- a/tools/testing/selftests/net/af_unix/config
> +++ b/tools/testing/selftests/net/af_unix/config
> @@ -2,3 +2,10 @@ CONFIG_AF_UNIX_OOB=3Dy
>  CONFIG_UNIX=3Dy
>  CONFIG_UNIX_DIAG=3Dm
>  CONFIG_USER_NS=3Dy
> +CONFIG_BPF=3Dy
> +CONFIG_BPF_SYSCALL=3Dy
> +CONFIG_BPF_EVENTS=3Dy
> +CONFIG_BPF_JIT=3Dy
> +CONFIG_SECURITY=3Dy
> +CONFIG_BPF_LSM=3Dy
> +CONFIG_DEBUG_INFO_BTF=3Dy

Please sort configs as CI complains.
https://patchwork.kernel.org/project/netdevbpf/patch/20260802151212.3294591=
-5-jkoolstra@xs4all.nl/


> diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bp=
f.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
> new file mode 100644
> index 000000000000..4f2414465bfd
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <linux/errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct inode {
> +       unsigned long i_ino;
> +} __attribute__((preserve_access_index));
> +
> +struct file {
> +       struct inode *f_inode;
> +} __attribute__((preserve_access_index));
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 16);
> +       __type(key, __u64);     /* inode number */
> +       __type(value, __u32);   /* tgid of the receiver being tested */
> +} denied_inodes SEC(".maps");
> +
> +SEC("lsm/file_receive")
> +int BPF_PROG(scm_rights_deny, struct file *file)
> +{
> +       __u32 tgid =3D bpf_get_current_pid_tgid() >> 32;
> +       __u64 ino =3D file->f_inode->i_ino;
> +       __u32 *owner;
> +
> +       owner =3D bpf_map_lookup_elem(&denied_inodes, &ino);
> +       if (owner && *owner =3D=3D tgid)
> +               return -EPERM;
> +
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c =
b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
> new file mode 100644
> index 000000000000..941b7decf798
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +
> +#include "kselftest_harness.h"
> +
> +#ifndef SO_RIGHTS_NOTRUNC
> +#define SO_RIGHTS_NOTRUNC 85
> +#endif
> +
> +#define NR_FILES 2
> +
> +/* Per-file content, so a received fd can be matched to the file sent */
> +#define SECRET(n) "secret %d", (n)
> +
> +/* Indices into the socketpair */
> +#define SK_SENDER 0
> +#define SK_RECEIVER 1
> +
> +FIXTURE(scm_rights_denial_bpf)
> +{
> +       struct bpf_object *obj;
> +       struct bpf_link *link;
> +       int map_fd;
> +       int sk[2];
> +       int files[NR_FILES];
> +       __u64 inos[NR_FILES];
> +       char paths[NR_FILES][64];
> +};
> +
> +FIXTURE_VARIANT(scm_rights_denial_bpf)
> +{
> +       int sock_type;
> +};
> +
> +FIXTURE_VARIANT_ADD(scm_rights_denial_bpf, stream)
> +{
> +       .sock_type =3D SOCK_STREAM,
> +};
> +
> +FIXTURE_VARIANT_ADD(scm_rights_denial_bpf, dgram)
> +{
> +       .sock_type =3D SOCK_DGRAM,
> +};
> +
> +FIXTURE_VARIANT_ADD(scm_rights_denial_bpf, seqpacket)
> +{
> +       .sock_type =3D SOCK_SEQPACKET,
> +};
> +
> +FIXTURE_SETUP(scm_rights_denial_bpf)
> +{
> +       struct bpf_program *prog;
> +       char lsms[256] =3D {};
> +       int i, fd;
> +
> +       if (geteuid() !=3D 0)
> +               SKIP(return, "requires root");
> +
> +       fd =3D open("/sys/kernel/security/lsm", O_RDONLY);
> +       ASSERT_GE(fd, 0);
> +       ASSERT_LT(0, read(fd, lsms, sizeof(lsms) - 1));
> +       close(fd);
> +
> +       if (!strstr(lsms, "bpf"))
> +               SKIP(return, "BPF LSM not active (boot with lsm=3D...,bpf=
)");
> +
> +       self->obj =3D bpf_object__open_file("scm_rights_denial_lsm.bpf.o"=
, NULL);
> +       ASSERT_NE(NULL, self->obj);
> +       ASSERT_EQ(0, bpf_object__load(self->obj));
> +
> +       prog =3D bpf_object__find_program_by_name(self->obj, "scm_rights_=
deny");
> +       ASSERT_NE(NULL, prog);
> +
> +       self->link =3D bpf_program__attach_lsm(prog);
> +       ASSERT_NE(NULL, self->link);
> +
> +       self->map_fd =3D bpf_object__find_map_fd_by_name(self->obj,
> +                                                      "denied_inodes");
> +       ASSERT_GE(self->map_fd, 0);
> +
> +       ASSERT_EQ(0, socketpair(AF_UNIX, variant->sock_type, 0, self->sk)=
);
> +
> +       for (i =3D 0; i < NR_FILES; i++) {
> +               struct stat st;
> +
> +               snprintf(self->paths[i], sizeof(self->paths[i]),
> +                        "/tmp/scm_rights_denial_bpf.%d.XXXXXX", i);
> +               self->files[i] =3D mkstemp(self->paths[i]);
> +               ASSERT_GE(self->files[i], 0);
> +
> +               ASSERT_LT(0, dprintf(self->files[i], SECRET(i)));
> +
> +               ASSERT_EQ(0, fstat(self->files[i], &st));
> +               self->inos[i] =3D st.st_ino;
> +       }
> +}
> +
> +FIXTURE_TEARDOWN(scm_rights_denial_bpf)
> +{
> +       bpf_link__destroy(self->link);
> +       bpf_object__close(self->obj);
> +
> +       for (int i =3D 0; i < NR_FILES; i++) {
> +               if (self->files[i] >=3D 0) {
> +                       close(self->files[i]);
> +                       unlink(self->paths[i]);
> +               }
> +       }
> +
> +       close(self->sk[SK_SENDER]);
> +       close(self->sk[SK_RECEIVER]);
> +}
> +
> +static int deny_inode(int map_fd, __u64 ino)
> +{
> +       __u32 tgid =3D getpid();
> +
> +       return bpf_map_update_elem(map_fd, &ino, &tgid, BPF_ANY);
> +}
> +
> +static int set_notrunc(int sk)
> +{
> +       int one =3D 1;
> +
> +       return setsockopt(sk, SOL_SOCKET, SO_RIGHTS_NOTRUNC,
> +                         &one, sizeof(one));
> +}
> +
> +static int send_fds(int sk, int *fds, int n)
> +{
> +       char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))] =3D {};
> +       char data =3D 'x';
> +       struct iovec iov =3D {
> +               .iov_base =3D &data,
> +               .iov_len =3D sizeof(data),
> +       };
> +       struct msghdr msg =3D {
> +               .msg_iov =3D &iov,
> +               .msg_iovlen =3D 1,
> +               .msg_control =3D ctrl,
> +               .msg_controllen =3D CMSG_SPACE(n * sizeof(int)),
> +       };
> +       struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(&msg);
> +
> +       cmsg->cmsg_level =3D SOL_SOCKET;
> +       cmsg->cmsg_type =3D SCM_RIGHTS;
> +       cmsg->cmsg_len =3D CMSG_LEN(n * sizeof(int));
> +       memcpy(CMSG_DATA(cmsg), fds, n * sizeof(int));
> +
> +       return sendmsg(sk, &msg, 0);

ASSERT_EQ(1, ret) and return 0/-1 explicitly, and..


> +}
> +
> +static int recv_fd_slots(int sk, int *slots, int *msg_flags)
> +{
> +       int nr_slots;
> +       char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))];
> +       char data;
> +       struct iovec iov =3D {
> +               .iov_base =3D &data,
> +               .iov_len =3D sizeof(data),
> +       };
> +       struct msghdr msg =3D {
> +               .msg_iov =3D &iov,
> +               .msg_iovlen =3D 1,
> +               .msg_control =3D ctrl,
> +               .msg_controllen =3D sizeof(ctrl),
> +       };
> +       struct cmsghdr *cmsg;
> +
> +       if (recvmsg(sk, &msg, 0) < 0)
> +               return -1;
> +
> +       *msg_flags =3D msg.msg_flags;
> +
> +       cmsg =3D CMSG_FIRSTHDR(&msg);
> +       if (!cmsg)
> +               return 0;
> +
> +       nr_slots =3D (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
> +       memcpy(slots, CMSG_DATA(cmsg), nr_slots * sizeof(int));
> +
> +       return nr_slots;
> +}
> +
> +/* Prove a received fd works by reading back the file's content. */
> +static int check_secret(int fd, int idx)
> +{
> +       char want[32], got[32] =3D {};
> +
> +       snprintf(want, sizeof(want), SECRET(idx));
> +       if (pread(fd, got, sizeof(got) - 1, 0) < 0)
> +               return -1;
> +
> +       return strcmp(want, got);
> +}
> +
> +TEST_F(scm_rights_denial_bpf, all_allowed)
> +{
> +       int slots[NR_FILES], nr_slots, flags, i;
> +
> +       ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> +       ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES=
));

then here we can use ASSERT_EQ(0, ..)

> +       nr_slots =3D recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +       ASSERT_EQ(NR_FILES, nr_slots);
> +       EXPECT_EQ(0, flags & MSG_CTRUNC);
> +
> +       for (i =3D 0; i < NR_FILES; i++) {
> +               ASSERT_GE(slots[i], 0);
> +               EXPECT_EQ(0, check_secret(slots[i], i));
> +               close(slots[i]);
> +       }
> +}
> +
> +TEST_F(scm_rights_denial_bpf, first_denied)
> +{
> +       int slots[NR_FILES], nr_slots, flags;
> +
> +       ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[0]));
> +
> +       ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> +       ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES=
));
> +       nr_slots =3D recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +       ASSERT_EQ(NR_FILES, nr_slots);
> +       EXPECT_EQ(0, flags & MSG_CTRUNC);
> +       EXPECT_EQ(-EPERM, slots[0]);
> +
> +       ASSERT_GE(slots[1], 0);
> +       EXPECT_EQ(0, check_secret(slots[1], 1));

Check secrets from 1 to NR_FILES just in case.


> +       close(slots[1]);
> +}
> +
> +TEST_F(scm_rights_denial_bpf, all_denied)
> +{
> +       int slots[NR_FILES], nr_slots, flags, i;
> +
> +       for (i =3D 0; i < NR_FILES; i++)
> +               ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[i]));
> +
> +       ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> +       ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES=
));
> +       nr_slots =3D recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +       ASSERT_EQ(NR_FILES, nr_slots);
> +       EXPECT_EQ(0, flags & MSG_CTRUNC);
> +
> +       for (i =3D 0; i < NR_FILES; i++)
> +               EXPECT_EQ(-EPERM, slots[i]);
> +}
> +
> +TEST_F(scm_rights_denial_bpf, denied_without_notrunc)
> +{
> +       int slots[NR_FILES], nr_slots, flags;
> +
> +       /*
> +        * Baseline behaviour without SO_RIGHTS_NOTRUNC: the fd array is
> +        * truncated at the first denied fd and MSG_CTRUNC is set.
> +        */
> +       ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[1]));
> +
> +       ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES=
));
> +       nr_slots =3D recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +       ASSERT_EQ(1, nr_slots);
> +       EXPECT_NE(0, flags & MSG_CTRUNC);
> +
> +       ASSERT_GE(slots[0], 0);
> +       EXPECT_EQ(0, check_secret(slots[0], 0));
> +       close(slots[0]);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.55.0
>
