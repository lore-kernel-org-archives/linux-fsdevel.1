Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41947B432
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778318; cv=pass; b=Zu64vqNCGG0LHQPqTPgnt8CEuY4BSQBJEnLIhugERyke4Yi/V+DuSsxtwDAcbpV1+cp9hZhSbpcL1M8SWyrFhCyK8CeDrBAgQTcGr98Ne0X6vmLk1tbdH0bMKApnIDKGGE08L6QzxLuRml9/VIeKkHv6VD09a3hCeDIlC3WFKUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778318; c=relaxed/simple;
	bh=W0+b9KvoApA0Cu4KJvDEn2s8LS//dxJC59n6wwetQT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOWUGKHimfBzy+YQDyK2FBYIUXYv5WB1w9sfWRXyfZYWtiri1I9cnXp8GBAGoQ8xiuSbw1fW/4JwF4fXlerKjD2UF/WoupM32ZWDePmOVwD2YZnnHK5iegLYZBENVsNLjFvoOHJM+k/mpzPoN5IlaKblrkAVpnMPSF/VRCIUcTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=c0ltu23P; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="c0ltu23P"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c252c7270faso483030266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 03:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788778312; cv=none;
        d=google.com; s=arc-20260327;
        b=Drw2pgUm+s8QfbaEAjWcD9t5sOBnJo3fmB2HUmBT71gWWwQIUkekCkk+PN2r/7cZPd
         LuTDLSITyBJaES5rXrc/XvikSm785LxkE+gkGeWZyT2AuA1DwXynWtDwE4EYasiGaYE1
         4ni1EGGXJFdqZSN/63Up6FoedyQ0EsIlkJYTC8tWwh2lMXdDTyVuHuIZMien6xpmWG9B
         lhf2mV1H+LfX5TZRH85kndsaMSgejwXJ8dNe78xaK0tvyrn2YPJ0GuTTjktMe+ZtP20X
         /INNr09mN5gEqCEZO8rmsWQbDQWsNw+DF03VkbLu8gGoKOXPXHnTK7qTKdQs6X31b4vr
         GOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GKeVIBKeBEiqOVb6fEusAWCMyuo++LHKEtSCxIMKohw=;
        fh=3qFQOeeUUMCdb0pyDRihXCV+AZpA2qt9XPzmeLvNPbI=;
        b=rxn2iSMMlmyqkL1nX/cy43fyRRihW7yUluPCvDNH9fO7wNu/OyuON8bzwpe6eCklIV
         lxAbFhzJRInBWV8h8SeXvHSBJTNY4NvIxFMtF8hryh6vafetFuBbC6jvpN3BaszcRbJi
         i3ptfrl/2X0crW8pU/y30aD66zZgZtH4NilL4y/aCuPQrJjGhK0dxBlzGHGF5SQF6mV5
         54oD7HNsl/VdVhOYMRuDgXHM9Gfce9OvhKFV0FN5WyvFm99bozN0SuuQuDFjX4inLonz
         9+yvkwSR3BhsoghipwAGVdhEnVrvInOE0tAFXE0N3dv17EmTiZ0fHtuXSpVPvXaBQIl/
         2W3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788778312; x=1789383112; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKeVIBKeBEiqOVb6fEusAWCMyuo++LHKEtSCxIMKohw=;
        b=c0ltu23PRE6Vkb70dkQgLopWyERqmVyY4VAevKZB3faJDwTC26STv7TqMJZ8hDC+Vo
         dRXOgDmhA2EKBpBCaDKCmZ3iZbyqlzxvReT4FsIuRxZoRmThb6SrYFZxFUMCaBC9UMc4
         g1dDH2OSaVvI2RuV6lrGWrbP2kkej9bBPSZ98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778312; x=1789383112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GKeVIBKeBEiqOVb6fEusAWCMyuo++LHKEtSCxIMKohw=;
        b=RIgjPfIFx7U5iip57CG8gVXC3dlKAtftF+h8viQghSknnGBBEOR91ff+c5fWUb+ZaV
         bnBDwaosyvjqC0dW0Ad3Yhw5k5JxBUWoMGD0SKYjZChsvYqyzMg+JFPii3g7VSEkHT/1
         BljFOxSX4rMmoMUQOQRIes2yB2fFRTjNg077titzKj/DC+hCuvy+ZB9mtXeIBCG6XPnP
         XN9a2wH/HubCZyT1nMmn90dk251fpLqEIgZTi5swLZcwAgZ91AYXQGXvQOzZXjAAHnDr
         9M9FyRc8jGajs4hIiyXlWhhPHWmn+BQ9CSJ/oSwuqc7ncG6r9uRz/hvfQEwz8qQy+Arx
         J9Rg==
X-Forwarded-Encrypted: i=1; AKwUvByLy2i/vGF9ljQj/7uG+Wcj/C4xw9tU2OhpcyebLiIcW5px2/2r3tq8f3jsVOeF7ES605v5nc36vRwdVTsa@vger.kernel.org
X-Gm-Message-State: AFuF++mdXf7J6lAit2yu4F8p9nm1fYCc4dPpKWDOi9SW0MzV73NMuzE+
	wQPho6vxyREg1gwCm1BaCzDDEmtvlFCivNQOTU1+c0+95kzdJLlzfHTnBZVan/jEJgy9BdQaflC
	K0blTgWtyxelxet/i/iBmqzkSMQdzegHoHuEAj/10Jw==
X-Gm-Gg: AYBFou3g5eLZCPvWl6N7stCl7l4sdPColQUyXr+XmIU1F+82ELTldO1uMe63zHPm6f3
	WMRxGmGTQM1/8xeM2j1p62kIjTfy+3AIEVgStSdR/+lI+aizJqV9RgUS5LLgUywAUYfm1r0/G4u
	53jMD/lAG9Y6zd3fZc/tT4p5vMQYGL34g6yb0FhggcQGxogE4T/DfMi4qabrJk/QIVZ4nk32K9O
	Oh+DSTERX7zCnM/fpJsRaZ0ByrxDpDX8Q8hHMWI3eFIta0Bvwo3JhuCrZmJ3LZPnbYYiaDM1GEl
	GBcu081BMB/gvuAITZJTkZ8ssDgmTI7mb0hyXK0N6c0ik33EuwGiN8OWUPMOlBwNleEMQXgrvAo
	=
X-Received: by 2002:a17:907:3e1a:b0:c24:87e5:6491 with SMTP id
 a640c23a62f3a-c260c971f12mr1411193766b.2.1788778312538; Mon, 07 Sep 2026
 03:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-8-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-8-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 12:51:40 +0200
X-Gm-Features: AcwNN1XE00oDe9AYh-ifVutenx203jQLfwtnAnzkRMIu2D8-Sqlf4xuqnAwBMnI
Message-ID: <CAJqdLroK2W7N59+96feng5_gPCHca81utJw0KsU5d1hpVMKFqQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] selftests/net: SO_PEERPIDFD_THREAD
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 31. Aug. 2026 um 13:21 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Add tests for SO_PEERPIDFD_THREAD.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  tools/testing/selftests/net/af_unix/scm_pidfd.c | 97 +++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> index 019c48e1cdcd..bbbd5e7b4fa7 100644
> --- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
> +++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> @@ -32,6 +32,10 @@
>  #define SO_PASSPIDFD_THREAD 86
>  #endif
>
> +#ifndef SO_PEERPIDFD_THREAD
> +#define SO_PEERPIDFD_THREAD 87
> +#endif
> +
>  #define CHILD_EXIT_CODE_OK 123
>
>  static void child_die()
> @@ -822,4 +826,97 @@ TEST(scm_pidfd_thread_creds)
>         EXPECT_EQ(ids.pid, info.tgid);
>  }
>
> +static void *peer_connect_thread(void *arg)
> +{
> +       struct sock_addr *sa = arg;
> +       struct thread_ids ids = {
> +               .pid = getpid(),
> +               .tid = gettid(),
> +       };
> +       int fd;
> +       char sync;
> +
> +       fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +       if (fd < 0)
> +               return (void *)1;
> +
> +       if (connect(fd, (struct sockaddr *)&sa->listen_addr, sa->addrlen))
> +               return (void *)1;
> +
> +       if (send(fd, &ids, sizeof(ids), 0) != sizeof(ids))
> +               return (void *)1;
> +
> +       /* stay alive until the server has looked at our pidfd */
> +       if (read(fd, &sync, 1) != 1)
> +               return (void *)1;
> +
> +       close(fd);
> +       return NULL;
> +}
> +
> +static int peer_pidfd_info(int fd, int optname, struct pidfd_info *info)
> +{
> +       int pidfd;
> +       socklen_t len = sizeof(pidfd);
> +
> +       if (getsockopt(fd, SOL_SOCKET, optname, &pidfd, &len)) {
> +               log_err("getsockopt(SO_PEERPIDFD*)");
> +               return -1;
> +       }
> +
> +       info->mask = PIDFD_INFO_PID;
> +       if (ioctl(pidfd, PIDFD_GET_INFO, info)) {
> +               log_err("ioctl(PIDFD_GET_INFO)");
> +               close(pidfd);
> +               return -1;
> +       }
> +
> +       close(pidfd);
> +       return 0;
> +}
> +
> +/* SO_PEERPIDFD_THREAD returns a pidfd for the peer's connecting thread. */
> +TEST(so_peerpidfd_thread)
> +{
> +       struct sock_addr sa;
> +       struct thread_ids ids;
> +       struct pidfd_info info;
> +       pthread_t thread;
> +       void *tret;
> +       int server, cfd;
> +
> +       server = socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_LE(0, server);
> +
> +       fill_sockaddr(&sa, true);
> +       ASSERT_EQ(0, bind(server, (struct sockaddr *)&sa.listen_addr, sa.addrlen));
> +       ASSERT_EQ(0, listen(server, 1));
> +
> +       ASSERT_EQ(0, pthread_create(&thread, NULL, peer_connect_thread, &sa));
> +
> +       cfd = accept(server, NULL, NULL);
> +       ASSERT_LE(0, cfd);
> +
> +       ASSERT_EQ(sizeof(ids), recv(cfd, &ids, sizeof(ids), MSG_WAITALL));
> +       ASSERT_NE(ids.pid, ids.tid);
> +
> +       /* SO_PEERPIDFD refers to the peer's thread-group. */
> +       ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD, &info));
> +       EXPECT_EQ(ids.pid, info.pid);
> +       EXPECT_EQ(ids.pid, info.tgid);
> +
> +       /* SO_PEERPIDFD_THREAD refers to the connecting thread. */
> +       ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD_THREAD, &info));
> +       EXPECT_EQ(ids.tid, info.pid);
> +       EXPECT_EQ(ids.pid, info.tgid);
> +
> +       /* release the connecting thread */
> +       ASSERT_EQ(1, write(cfd, "x", 1));
> +       ASSERT_EQ(0, pthread_join(thread, &tret));
> +       ASSERT_EQ(NULL, tret);
> +
> +       close(cfd);
> +       close(server);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.53.0
>
