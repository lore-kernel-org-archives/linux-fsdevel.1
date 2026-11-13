Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594073;
	b=WC3tcRTa0lP2M+pS0JxSxRzGS/uE4wcMRDIe+BMJv/D7JQ+xxEYcWdvg3nz6HLgXJgfZ
	 64B8uCbNI66nvdzEaMCSCrgKk62Vsp7piyi/p//QOsXrnWuNq9FiSiq7KskKiWv1UFt3V
	 DsmuF4VpRO29f+M//siro5RHLsPMrxIGrwxhaKqP26nIckeQV4mBG8KdgJ8Qzq6ECUzaX
	 WmhRw4hSv7NbgEdaRm2t1l7L13zfc5oA3cjlnltUgiJjJU+iaf9TcJ9q0WJcb9jJ0hARD
	 yZzYuu479rFIi24nt+t48LUDlfTyeaoZl6fOHI237Jb64Cna5v5x36k6YTNnq2xYPiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=54eDC8uXlfRGhMfZUiK757c5spN/BrnlZsySaiQPqbI=;
	b=x9Uklt+CzPcwg6vuClvek+jnQTJMK9cbEPocjMmLPX55n1tYgqO6uZ9YrPXPXEF9FNcH
	 +OS1E8QXOFXE46MKR9V5DuxLJufGE0bCcQB+uvhFIB+VEQVZh2H2+QKjI2/3LHXCD05mH
	 EY0geCsBrbkISxgEHVkHdM8EQFVSFe3Y2EdUkGggNjVQqg/HHuMtiPTsnaZV6FxuJvdW5
	 tadSM4XTXeXjNIZxTClrDQ0qbSu005n3uDUP2RwMuY+/k63ak7Xi/fT4clM/ruLRetlu6
	 x/EimgJ090vi2An40z6ubGAxKdJx2DqpBF33+krOi4NQQrIOriNPNZLANvMdQLW9YqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzlshJGu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD6606A323
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 18:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0DD6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzlshJGu
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b757029223so1923165a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:21:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794594071; cv=none;
        d=google.com; s=arc-20260327;
        b=dJgCPsiI3ek+0jL30k4W052qIUvMJiF2T/cBSPMpGeAaLPBoyv2e6hUmUYV6QfdIEq
         wvkIBCJxi271uTQZN9kK2sfRWI2dRPJTsb7ZVrMjOpFWgQLXDfuuR6oMfEDfC3AH362b
         +CZfhU0C3RlvCj5/O3G9T/StHFy/+e8IL3kqhpBLytbUaz2dKJz0FFmY+49us72BPwUJ
         4UO8Qdc17Y9uoxmR6TPF63+q7AG8WoSDn3yUYODdrEzOAZaxWcjHC7mLkhyf+NZKJ21N
         8LJPRuFOv8IuP3P6m1OHInVjvdUjGFNALzF7qb+Y7i8pMl/Z/dsGCvdRmG2dR+nm0zZ6
         tEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=54eDC8uXlfRGhMfZUiK757c5spN/BrnlZsySaiQPqbI=;
        fh=2qVpsI1b8fYJiOsOjMAckCHWcweQ2MPbd459o7bw1+4=;
        b=PiKkhAzHkkYmPyrJEQnVXx7hV6LrrxBdMb8DDru8mpIRsRH6ooCNqhoX891qR7S4Dn
         tB2GdmBOp7J7atmXWXSMhnMJnJUV5DNLG/3anLwyeWHQ2NFaWJkJBfxQH+wNprGKvyvH
         ERlJedLgEZJ0OePpZc7vxA2touLC+DHGRBKVtKVyImA4sbbZ/B0tw0kPIECwPYxWMyzX
         mRILmtbm/mM5fqjBEMakMrySYdhcmQ2ihliIYEQwAZauWl7f5qneAoyszdhPPGi8QnEh
         gMzWdhm0MvPgpPP/NtF5d5UZ3l4JH3Xjxv1qOJUUNQGW8nr6vcX3yIupCR2xFCxfLCBh
         r3Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794594071; x=1795198871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=54eDC8uXlfRGhMfZUiK757c5spN/BrnlZsySaiQPqbI=;
        b=bzlshJGuEZXIycAFYX1mYd05iI+/Izgfmz+50e4WjeeRavo76Blx1Gh7QyMElCUu7Y
         keqVzTwcdHnt7C6N+Bhh0D1nHg6tsuG5ACPurYgjZlW74WDCSYSs/YNtzZw4aDHt7jGT
         v2Z9rbQNtkrY8+T9mhhKMcWDsS1q2N8X5tOTm+R2axSUoyY5bE1GsUqbSmOMEyhlfQdT
         GPB7SS2M+l68v57Kh6NdRb9AGWpmCrX+FI6Hc9VrtiqpaAyVmuRTKqSsbkZV390MRLzk
         ty2X1EAFcjSDsWrm12wKyDZu54jF+TCnzynfbTyeV81KmkkR8mBv3zaH88u7N48AT3Jr
         mAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794594071; x=1795198871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54eDC8uXlfRGhMfZUiK757c5spN/BrnlZsySaiQPqbI=;
        b=m54XOMfKS+iPWdOacgbpRIKOkFM9HCAp44CdbITAKibv+tSm+cxQALDtVrz+Z54ue7
         +wPEWgw4YNQkivq14DVIGGPxWA5zMGWTQNos5u1GSmwGb9A+t3CQI7xZijkxscciIiea
         C1cLQFxhm007Mj9oRn5XIgo/KiAXBP8Bn/QEHXQAS5NWW6H3iOLmeEWJE0JMfcwz3dHk
         vcg3/j2HEG4SRWoFLzWJlwwo3gbh+DNRpoFxdqTZEzF6J9Wx3AvlJNB5doGymbVK42yE
         tzlbjlIhmOpchf7/yqXlzYaLjCptg21Q5/94kpWArOH6IV5TBGAEb09FNuTMqzdVZjgf
         KpkQ==
X-Forwarded-Encrypted: i=1; AL+hErHMQKZ23lMwPqvWVHnAtqjSfPTiHALZXR7MDA3ywBqzgCjbXaP/SAJwqPEMw32QBjThwy0h1PbxMvJNOW+F@vger.kernel.org
X-Gm-Message-State: APuU4Z+hpW1bPIXSOU27DDa73X14h/j1Xd1OdrIqwIl6MPw+JndVZy5O
	jZnJXgpfPHLJu9cXwaYcWYu7MXbtc1Gvo4kS70CIxyD51MUZTOu2thP+SFbiN7uTb06eXN14Ulc
	EskeNPWgVeIXLGU6D0KZqP2tppoFwV18=
X-Gm-Gg: AYBFou3VLrbVPgsKffHQmOdmQLsr0GEA1u7LQJZBNJcPa8HU/JXElkmRzHT1Z8X8HM2
	Kyj+oEdkYei1IlZ3/pdHBG1nJBKfDJoNfeTtVjU5ELSNidaUEHJ6SrxBWMdlX+89v/+skLr8t5t
	4JOZRA2bEwPCWWi6z6OmolhnIuIjJn8VDyRapNAYP3cXShJj6aC2Oz40WE2EO/3oNLValAc+93l
	vx4JFjw9qdwJheJvz56jUobEvlM06oYmhyu//sN8Prio2LY0TcrTN3/G6QvGjT2YIsyx1i1eVW/
	TbcxU9v2lPENzp/nlhrZPWUGShH8wPx3j7g+P1Rh0AH1NtXgd3RTPuhYjEZGwLws/V31F1ofnMl
	FZc/Qc0vFebk9jOOxsIdVBUW/ezL0JWktJo3SopLKIFaMBnAG4j/1V/7umBZmTifGJOmfFA==
X-Received: by 2002:a05:6402:1e91:b0:6b3:f81f:927d with SMTP id
 4fb4d7f45d1cf-6b7c08b4b99mr3140320a12.6.1794594070836; Fri, 13 Nov 2026
 10:21:10 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015143601.2095784-1-amir73il@gmail.com>
In-Reply-To: <20261015143601.2095784-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 13 Nov 2026 19:20:58 +0100
X-Gm-Features: AclHuK9NOBMQ9uZ6tHtgWdIUN2ujkm7xaWSiBCvYS9muR6Awhd6jpK96RhqZqws
Message-ID: <CAOQ4uxh7oEQ_BzzN23C87+LN1SLoNz2PNYi=k3fNn-NHG4P-5Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Partition the fanotify watchers by type
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:36=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Jan,
>
> As discussed on the "namespace monitoring" patch set [1], the proposed
> namespace events do not need to be mixed on the same group with legacy
> fanotify filesystem events.
>
> The mount events are already not mixable with filesystem events, but we
> want to be able to mix them with the new namespace events.
>
> Therefore, introduce the concept of "watcher type" where all the legacy
> events belong to the filesystem watcher type and the new mount events
> belong to a new namespace watcher type.
>
> The new watcher type is free to reuse most of the 32bit mask space that
> we have internally in fsnotify for event masks.
>
> The prep patch set only does the partitioning by watcher type.
> Followup namepsace events work in available for review in my tree [2].
>
> If you are fine with this plan and have time to review the patches,
> perhaps it is not too late to stage this prep series for next cycle?
>
> Otherwise, we could aim for merging this together with the namespace
> events for the following cycle.
>

Hi Jan,

I suppose with the firehose of bugs you had not had a chance to look
at this yet.

Just making sure it didn't fall between the cracks.

Thanks,
Amir.

>
> [1] https://lore.kernel.org/linux-fsdevel/20260424170503.2096847-1-amir73=
il@gmail.com/
> [2] https://github.com/amir73il/linux/commits/fan_mark_userns
>
> Amir Goldstein (14):
>   fsnotify: rename fsnotify group flag macros
>   fsnotify: introduce fsnotify group types
>   fsnotify: separate the events bitmask macros by group type
>   fanotify: test event->type instead of event mask when possible
>   fsnotify: do not report mount events with fsnotify()
>   fanotify: gate filesystem event classification by group type
>   fanotify: define event mask constants as 64bit
>   fanotify: define new FAN_NS_MNT_* constants
>   fanotify: gate event mask in fanotify_mark() by group type
>   fanotify: introduce FAN_REPORT_MNTID
>   fanotify: introduce FAN_EVENT_MATCH() macro
>   selftests/filesystems: create fanotify test dir
>   selftests/fanotify: update the uapi tools header copy
>   selftests/fanotify: test the FAN_REPORT_MNTID mode
>
>  fs/notify/fanotify/fanotify.c                 | 186 +++++++++-----
>  fs/notify/fanotify/fanotify.h                 |  38 ++-
>  fs/notify/fanotify/fanotify_user.c            | 230 ++++++++++++------
>  fs/notify/fsnotify.c                          | 106 +++++---
>  fs/notify/group.c                             |  15 +-
>  fs/notify/inotify/inotify_user.c              |   2 +-
>  fs/notify/mark.c                              |   2 +-
>  include/linux/fanotify.h                      |  45 +++-
>  include/linux/fsnotify.h                      |   6 +-
>  include/linux/fsnotify_backend.h              |  83 +++++--
>  include/trace/misc/fsnotify.h                 |   4 +-
>  include/uapi/linux/fanotify.h                 | 100 +++++---
>  kernel/audit_fsnotify.c                       |   2 +-
>  tools/include/uapi/linux/fanotify.h           | 100 +++++---
>  tools/testing/selftests/Makefile              |   2 +-
>  .../{mount-notify =3D> fanotify}/.gitignore     |   0
>  .../{mount-notify =3D> fanotify}/Makefile       |   0
>  .../mount-notify_test.c                       |  51 +++-
>  .../mount-notify_test_ns.c                    |  54 +++-
>  19 files changed, 707 insertions(+), 319 deletions(-)
>  rename tools/testing/selftests/filesystems/{mount-notify =3D> fanotify}/=
.gitignore (100%)
>  rename tools/testing/selftests/filesystems/{mount-notify =3D> fanotify}/=
Makefile (100%)
>  rename tools/testing/selftests/filesystems/{mount-notify =3D> fanotify}/=
mount-notify_test.c (90%)
>  rename tools/testing/selftests/filesystems/{mount-notify =3D> fanotify}/=
mount-notify_test_ns.c (90%)
>
> --
> 2.55.0
>
