Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CB3D810F
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379846; cv=pass; b=Xp5B07ioFWGbmlHeoZJ/t+tV85yNVdZBCT2StP3oOcLxJkSUw/7Nv9BE/gJ3p0vU1IzEaCSuc0AuW1Mq13FVEVKeFyqgkm6KWhdDMMk1U6p6Q/06Evx+yhrrWOkrNOCShsPjnJDKOM2fQ1lyxLsI3dwHd234DMnWxgqrLpTa9K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379846; c=relaxed/simple;
	bh=dLk3l8o6wKpS2bhAj8bomNH493j7PIlHJrP2s7SSSzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0M6uYRdxeIBU7QCkLpxgiQ0KdWuvvz91cwx6GCUsvFj1/WeK9a3l9j4Yksikzh5Jokmv6QG1aK+A34HDe3C1gevcjZ/hD5BHwwTiEjcitmkoatTSBZw78NIo6pm8oa8vcGHRaU9wHWyqow++L4vagoyr6qhOquWo9ldFjfDAd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onk9ehAK; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onk9ehAK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacf197759so56498665ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 16:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783379844; cv=none;
        d=google.com; s=arc-20260327;
        b=A8wSyVurUcrGdJaNUNoOteLLm0GjEQSkpdlkg0j7pnyEbi8IJkhG3whrPXugv5CMl7
         NCuJtmBGbvlFl7NKIf3OR+JvncGDbxxIohPPdmC/D05KDzZ4vSOOKHG9Q5hpTcG47aEe
         fbbHstmTXfxyRA3JD5gRPxiAQceslmJ1jq2PveJfECXhZZ+p5RwTiI4l3afB9110SuzX
         ArNzpp2/1tvJDeELgNqp7ONrYhMGzrqxVOYVEzK5DqiPQhhlRK7wKSk2VTt0hhwpSHON
         GMrox8dVmcDZ2L5k7+NmiSDphre2Ggu0EnNOk+HT2FxP2TySsqfx1a2sT9bL2eyy4tBZ
         8q2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+8qKp600TVGZqCnC9V4CuKTCWgTklOkq2jFp4B/wF8=;
        fh=4SObHZnsiEDK+GYNBJ4ApMi86Uj4ngODw6FEXNjXODY=;
        b=VmIzrhUhy9wP5U2CCEhAtw+j8bEutiID/OSWNoXoUPjDFT5MYL3Dmsl0oTKlk9lWSN
         zPvH1H1IQU3lHqaE26u/q9b2vaND91Oaj6TobjRk9qj0hIwbgBkyIbgoPVaqKTVcMcMU
         JhgN8diT0ikolBAI85VZgeGXaRq2qnFTnBlaC1Xqzm9joP858YKoZuk9YW0Kx4kvfVrO
         NwJZQbG8I0tX/w8oB0YIfRY4VF2rYIwFxavR0B+N/728r/wb7s+evaSlS2TTZIileP2j
         ++DrkFb1NG56Vwlw6I/s/fS9643Jj8vLXbH23lGywKha9ObJ/eTY6ylwwSQdFO0WzXxW
         2cWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783379844; x=1783984644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+8qKp600TVGZqCnC9V4CuKTCWgTklOkq2jFp4B/wF8=;
        b=onk9ehAKukv9SrKG2pmgsC/pGjqcl2y4gNZ7+BKuzIX8bB6vSLNJ8I6BnGW070dXK6
         wmQcn3PlYzmTpGY8y5aXG3MWzo6lkoLjNcLZQK+W2AV6ziQwxqj6bNRXyDB6PG50dKcs
         V2dFokHG8Bx46SDq+Ce+n7srJVGj4FLbkQpVZq/GoP2lAyN+hK4NKZj+eXF5Irt3Iwey
         BhvDCeEnzm2M24VEGX42nupmb/HV5nCv80ycWi4kMJAhQnYVKdj/JA8CluC3nGI1ZTcS
         +VvLXPX+AjvqXMP6A0Dm2+kHFnzMySi3tKidpdsSLpRFciPc0S1UrwPE0g8Eyw20IEPh
         ll3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783379844; x=1783984644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+8qKp600TVGZqCnC9V4CuKTCWgTklOkq2jFp4B/wF8=;
        b=o2dhlP85gQbF4J3URqJLMZ1AIz63/flvL5z+mWITXgl6auzf1nZG1P+2i9G8N1WF5d
         J1XeZMcoOFZVoy2QXNd8f+lqZ2puJrePx24YnT+ncFcVUZ6RdHcm7Iw8uuYoxlD7tOVe
         gH6Jtm4zGDndsvUzAvJDjK9nG/L72Ck6MK5k6MqhXCues9TR8ybN+lUK9etzd3CKwUwB
         bHCImDlxvws4klA4V9o5ysy28i2li7R1I1iMPdxohSNgVutrU3qMOVPFY8JXnKHwn+Ka
         tKcKyKKOwny+kegwkgMslxFurlTKSzm6o+6cuHd7LswlHbkSgzav2W8gpLFPbYAFO4r2
         3+Bg==
X-Forwarded-Encrypted: i=1; AHgh+RpUgDeklnEkoh5OveGcBJR7s1Gao5G0NBvRuQ0yQl//kVfUWD48eNl8o+guyg6xTCIWfJ/dvPAKn8Mo4Hw+@vger.kernel.org
X-Gm-Message-State: AOJu0YxrR4C5lCEOHJG5UJl7d3kGQ6udTsaQMKC7Og2BmLa7+D5SUbRk
	iMTHehZq11U12kOo1GzlsRqU53Yf/Ibg+MRTrcxsiu0QBGYdFCxhTY+OHRp0O0jBZFyfhu4PyG/
	nTbM8HAxwm8Otx8dAgDWdcV5MPXUY5zAaRTkbmZba
X-Gm-Gg: AfdE7cl7ePqxM7yqUuHZI9/GVj66fOBXuvDZ1xC8HP42fe1k4wUtI/FvpxxIc1c95Mi
	Z0gdksnIsxJCxbtqxG9vPyIaWcbOiuCkVAWy8WhTvGeJZyXQtZugFABnkoGlvo+Hj6kaiWABY2p
	/aY9b4n9M3scRtlPJEHkuY7yL8zfIZpfI1ISZ5d3bpOUm46kajH/cbSBWRZ5mB9AYQWvW1PqecX
	7BSVjosgBwlPZmVdo6tzWMuP8I9lIVtu6iXN6r1DgEkdWo3Ri9u6ysDLDZ9h9TKQvyGjmNzvLCd
	c4cDlQxsidsT5+I7HSMnqqFMD4CNRVnLGwuocws5eh469Ug9n+Ljljd0o+F42GCQfPSO+4SdJsm
	ohohLRq48p5+L0JOLkaesK+6okTtMGw8b5hDc+A==
X-Received: by 2002:a05:6a20:c786:b0:3b3:be05:2b73 with SMTP id
 adf61e73a8af0-3c08ecd72famr3009005637.18.1783379843218; Mon, 06 Jul 2026
 16:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705123826.3818443-1-jkoolstra@xs4all.nl> <20260705123826.3818443-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260705123826.3818443-4-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 16:17:11 -0700
X-Gm-Features: AVVi8CfHos24Kv9fVUY1fKP13GD0sDCI86-gLPvh-ecHWsAM5E-pX13a8-b3DE8
Message-ID: <CAAVpQUA_hhHRr60HWmZqHMT5Gfaiq6D8zjmuqT3KikuUtm9Eiw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 5:37=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
> Tests SCM_RIGHTS fd passing on a socket with the new socket option
> SO_RIGHTS_NOTRUNC turned on. To hook into the security_file_receive()
> call, BPF is used. The BPF program shares a hashmap with userspace that
> lists the inos to be blocked (of the receiver tgid).
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> Assisted-by: LLM # used LLM to get skeleton BPF and libbpf code
> ---
>  .../testing/selftests/net/af_unix/.gitignore  |   2 +
>  tools/testing/selftests/net/af_unix/Makefile  |   8 +
>  .../net/af_unix/scm_rights_denial_lsm.bpf.c   |  36 +++
>  .../net/af_unix/scm_rights_denial_lsm.c       | 263 ++++++++++++++++++
>  4 files changed, 309 insertions(+)
>  create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial=
_lsm.bpf.c
>  create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial=
_lsm.c
>
> diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testi=
ng/selftests/net/af_unix/.gitignore
> index 240b26740c9e..5034482f8864 100644
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
> index 4c0375e28bbe..594cd26ec398 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -11,9 +11,17 @@ TEST_GEN_PROGS :=3D \
>         scm_inq \
>         scm_pidfd \
>         scm_rights \
> +       scm_rights_denial_lsm \
>         so_peek_off \
>         unix_connect \
>         unix_connreset \
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
> index 000000000000..b8656de86efe
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
> @@ -0,0 +1,263 @@
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

Could you add FIXTURE_VARIANT() and cover all types ?
SOCK_STREAM, SOCK_DGRAM, SOCK_SEQPACKET


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
> +       ASSERT_LE(0, fd);
> +       ASSERT_LT(0, read(fd, lsms, sizeof(lsms) - 1));

This style is easier to follow the logic for me.

err =3D func();
ASSERT_LT(val, err);


> +       close(fd);
> +
> +       if (!strstr(lsms, "bpf"))
> +               SKIP(return, "BPF LSM not active (boot with lsm=3D...,bpf=
)");

Could you add minimal relevant configs (CONFIG_BPF_LSM etc)
to tools/testing/selftests/net/af_unix/config ?

NIPA (netdev CI) uses it as the base config.


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
> +       ASSERT_LE(0, self->map_fd);
> +
> +       ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM, 0, self->sk));
> +
> +       for (i =3D 0; i < NR_FILES; i++) {
> +               struct stat st;
> +
> +               snprintf(self->paths[i], sizeof(self->paths[i]),
> +                        "/tmp/scm_rights_denial_bpf.%d.XXXXXX", i);
> +               self->files[i] =3D mkstemp(self->paths[i]);
> +               ASSERT_LE(0, self->files[i]);
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

nit: newline here

> +       return bpf_map_update_elem(map_fd, &ino, &tgid, BPF_ANY);
> +}
> +
> +static int set_notrunc(int sk)
> +{
> +       int one =3D 1;

nit: ditto.

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
> +       nr_slots =3D recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +       ASSERT_EQ(NR_FILES, nr_slots);
> +       EXPECT_EQ(0, flags & MSG_CTRUNC);
> +
> +       for (i =3D 0; i < NR_FILES; i++) {
> +               ASSERT_LE(0, slots[i]);
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
> +       ASSERT_LE(0, slots[1]);
> +       EXPECT_EQ(0, check_secret(slots[1], 1));
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
> +       ASSERT_LE(0, slots[0]);
> +       EXPECT_EQ(0, check_secret(slots[0], 0));
> +       close(slots[0]);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.55.0
>
