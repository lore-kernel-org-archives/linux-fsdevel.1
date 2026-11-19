Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095740;
	b=Bax/86pj2tkrbwiPuP1Kgp2ARH6vg95vXOQ7MoyBgsSlTfb4+a+vbX72mTHwIf05km1l
	 o4jfqH0A4vtTHtVT/kR+4SyeYUnqP3KxbAsvKQZvORtbag6aVQy6Hym1g0eQ8PJ8mFyDf
	 NtcVugwpTkaV1HtrXpebQ92HXCabTkYINPF0+fXIm5+kx6kUtZtlYpvU6YNZQK/zFLOkS
	 RP3chzp0ulLbzCSrtLn0w7hZEEKF9npkHNa1lh4JUbyMxDQ54GftNkrcsBNoyARAw33EO
	 SvBrBqUADTle1M6rHpPsovFOlMcQAwHp3ZbFR6QQ1U0FuEViWmWQN0LCcb36iWRUACQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=LsU8Zjx85+8Bc4fkBL6bsA4+NBo/da2SQz5szSsymVw=;
	b=G90GYIWbtPKdg1ZiZPqOh2UyTVObCgswjx1Aj4fIdHduNY3UlzB4kBEtAKcVx1Sdc7ks
	 B4C/4xih19gyLPMziicYFsRH90/xbs61H1vD4EAcfMv4Iy5wpg+A9diP/fG4zHLOafxUW
	 NSzafd013BvqY6EuyIcqKiCkUVamW2iAGNrlc362vJZGkzmvXYd2MlX5xgWeDzfCy0s/K
	 q6HNvRTbeIJ0+N7ESbMuTg/hLBLOqBrFjuONjJblzkd7KIVu3l6lZaiqknkvfvu8bidvh
	 LOCfDSaYI+XxHrM4T1TYjOnV+pR0hLe7hqoQ0q1L77OLwaP4SLIW0UZg5NBjOJvcKUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZEpM7oQ9;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698460A2600
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 13:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B698460A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZEpM7oQ9
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so20334555e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 05:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795095738; x=1795700538; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LsU8Zjx85+8Bc4fkBL6bsA4+NBo/da2SQz5szSsymVw=;
        b=ZEpM7oQ9F48EoPJ/3iQMrQUiqSXJxvckMmoaQM0X6ue6VQrsD2bzvMPbJuI3lzYt+l
         qNg7bMquBuJPUrMKac9sQY4E3sSv+fEcqJdzpmxc0ETpzivfk8n1NYXlXh8xO3YVLfW1
         aNSfIHH170nuIwcc6Ba9wWVDoyqwwwDCQ8nWWxEwiZooHarblvJG+EIoLbkXr/PxpvtX
         HhCUmTHLrR2eTkmy//Rfx3aH26h1m0nF9uc5VbT6bCQg/UYtxze4js7R7BFkK9we8TWJ
         e/3FjVCYRDWcz2yEiE4zKo8eEFsm4kxNcIR8MvsfGPLAt6w0H4yxe3bY8yAwAQbtgcH9
         +Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095738; x=1795700538;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsU8Zjx85+8Bc4fkBL6bsA4+NBo/da2SQz5szSsymVw=;
        b=R2nukSz7RS2g/53wVOV4FyVJdlIbzM8J0pjkzlrZubOn+lGGdd+rzIH3kaIHRnm/iy
         JamrknZQMl07sab1YEBBwawzGDOPpQxesBs2GxGElxJDqzynenH5K0JLwbCAzfvobVA0
         h0ePpnnpWhD/7LPdS5FkZDn99oGSKvOrRatFIEkqns6iAsLHkwk9SPvZNrbb5nuLA1Hm
         4s6xdaD4puSyUoZ86jYyOva+JkapK5hmr0bpwU5PW2WLv/FPYIS5+eoLHr2OcqDARAUi
         mp6DkFIyG01gJ9dJfqRsLHfZbc79DsR+d+kXGliKB0kB4QnivJLtsZLnb1/11N5z/wuB
         8jvQ==
X-Forwarded-Encrypted: i=1; AL+hErHIrW7Mitl4+9Of9V5kxdQAPilW4Fq8nOFSPlHFz4pxZ8vtZg+VFzYrbXtJjKggzT/+ef+0qfXZHAaD+qTm@vger.kernel.org
X-Gm-Message-State: APuU4Z+VC2j1p69BIYoOkjFv9Vs48EUV1DFr5K8bwNynrUMY25xfFl8c
	SVCW7pDlm5UHPNfA4yi8sZeRxWhTwh0kvQQjNHEbEpLavBe8JPyInGIZYpuCJhz42v50HU/+GcH
	iw56C7o3D
X-Gm-Gg: AYBFou1QDkb/GDkw+2EveV7lo9QO178J3EqJhtjMKy/PdElt84HUp81GhrsOmiK6Rvq
	c+I+YzybzIs54nPSmmFLSUqLnbIT7hJU7aZit6DiQx0Fc8Ieop6nAi8x1tK8wbqI9JdCybqjcfr
	r3etEVhrcVoL4ONNUJRge7SrpvxygZAG9Ca7l4Fu4kXqAox500RfyFFrWga+yEKVt0leCmlSg2A
	sXDbUe1hbV1UlW/yIJcqis7AHtocIcbCwAvnPgQiBNTx2+AcLIpQROkYAv+elrjJEeqf09auSzs
	/Kceu36J4iND4lJuLK8V97+hdAkMNSogB+piAOHC5Ci5HmH1/vwFqO78on6WZpEik34QjSFynoR
	aaR03vke0dnneP3w6fSJavooO8GsXczsOJJP00X6V83To5JYKmukl0SyYYuUIAT5xGTHPavwjpw
	KdQbnFh+HnljPCbcRgbdO4k3770H2Ba3G6wfCZQT1wa22KOjTjTQQ8ljcgVrfv0i9sNEfr8TJ1Z
	u440dB2yT19fK9/Je9+uoGGevwh6gw9xblxLNB1bAm5sstBxcEL/XYoGgKPEawGd1wpjdL+CWPG
	8EVVxRxWxedOVndoS/ichwfZ2icAzW+iUjtUHDOEKs9UUroacaStDRlRbkvMnkj8H3NnepDh/Yq
	cwVBbfX6lZEl6zIchXvS6LHV8g03A5YL5pMEGbTPhnBXqpOoA/Vegxw==
X-Received: by 2002:a05:600c:4e93:b0:4bb:5c92:ce12 with SMTP id 5b1f17b1804b1-4bb7da12f06mr122414505e9.17.1795095737895;
        Thu, 19 Nov 2026 05:42:17 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:677:1cd6:7e14:6fa6? (p200300cf572c280006771cd67e146fa6.dip0.t-ipconnect.de. [2003:cf:572c:2800:677:1cd6:7e14:6fa6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85372b67sm39429045e9.13.2026.11.19.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:42:17 -0800 (PST)
Message-ID: <3e4103cbcf7b76535e2f957762174515ef00f08d.camel@amutable.com>
Subject: Re: [PATCH] pidfd: restrict pidfd_getfd() to the caller's pid
 namespace
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Jiwoo Kim <arpe1618@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Sargun Dhillon <sargun@sargun.me>, Arnd Bergmann <arnd@arndb.de>, Jann
 Horn	 <jannh@google.com>, Chen Linxuan <me@black-desk.cn>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 19 Nov 2026 14:42:16 +0100
In-Reply-To: <20261117152332.1221-1-arpe1618@gmail.com>
References: <20261117152332.1221-1-arpe1618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-18 at 00:23 +0900, Jiwoo Kim wrote:
> pidfds can cross pid namespace boundaries: a task can obtain one for
> a
> process outside of its own pid namespace hierarchy through
> SO_PASSPIDFD
> or SO_PEERPIDFD, via SCM_RIGHTS, or through file descriptor
> inheritance.
>=20
> Commit ee8323fdc827 ("pidfd: restrict task access ioctls to the
> caller's
> pid namespace") made the pidfs namespace ioctls fail with -EREMOTE
> unless the target is visible in the caller's active pid namespace, as
> PIDFD_GET_INFO already does, following the rule that operations which
> grant access to additional resources of the target require this [1].
>=20

Hi Jiwoo,

> pidfd_getfd() grants access to the target's open files, but it only
> performs the ptrace access check, which does not take the pid
> namespace
> relationship between the caller and the target into account. With the
> caller in a child pid namespace and in the same user namespace as the
> target, PIDFD_GET_INFO and PIDFD_GET_UTS_NAMESPACE fail with -EREMOTE
> for such a pidfd, while pidfd_getfd() on the same pidfd returns a
> duplicate of the target's file descriptor.

It it an interesting point, because pid namespace itself it not a
security boundary. While user namespace and capabilities are mechanisms
to manage permissions.

Currently, you can do something like this on your machine:

# Terminal 0

echo $$ # note this PID we will use it in "Terminal 1"

# Terminal 1

sudo unshare -f -p=20
echo hello > /proc/<PID>/fd/0

and this will actually print hello in the Terminal 0, while the process
doing that lives in nested pid namespace. But this is not a problem
because this guy is a root:

# Terminal 1
cat /proc/self/status | grep CapEff

So please understand me right, I'm not saying that your point is not
valid, but I'm not sure what was the intention behind pid_getfd() API
in the first place and we might want to have semantics and model close
to the one procfs has.

Speaking about other cases, where we *do* have this check:
- for exportfs operations it completely makes sense, because filehandle
  contains an inode number and user space may accidentally (due to the
memory corruption or purposefully craft it). When I call
open_by_handle_at I *do* expect to get something from my own PID
namespace.

- pidfd_ioctl since ee8323fdc827c580425644db605a4be776cace57 ("pidfd:
restrict task access ioctls to the caller's pid namespace") doesn't
allow to open namespace files, while procfs has no problem with this
(it works you can try)

- pidfd_info() also forbids cross pidns information retrieval and for
part of it functionallity we can do it through procfs, but for exit
info or coredump we can't

To conclude, it looks like we have a little bit of inconsistencies
around here :-) [ But please, don't go and change anything in procfs as
we might break some tricky use-cases like CRIU and SCM_RIGHTS users. ]

IMHO.

Kind regards,
Alex

>=20
> Apply the same rule to pidfd_getfd() and fail with -EREMOTE unless
> the
> target is visible in the caller's active pid namespace. Callers in
> ancestor pid namespaces are unaffected.
>=20
> This was found with an AI coding assistant, which also drafted this
> patch and its changelog. The problem was reproduced in a QEMU guest,
> and the fix was tested there.
>=20
> Link:
> https://lore.kernel.org/all/20260925-gewischt-auftrag-tierzucht-c153cb3f9=
f74@brauner/
> =C2=A0[1]
> Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
> ---
> -EREMOTE is a new error for pidfd_getfd(). The check is done before
> the
> task lookup, so, as with PIDFD_GET_INFO, a reaped target outside of
> the
> caller's pid namespace hierarchy gives -EREMOTE rather than -ESRCH,
> and
> the check comes before the ptrace access check.
>=20
> setns() also accepts such pidfds without this check, but it requires
> CAP_SYS_ADMIN over the namespaces being joined, so it is left alone
> here.
>=20
> A reproducer is available on request.
>=20
> =C2=A0kernel/pid.c | 14 +++++++++++---
> =C2=A01 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/pid.c b/kernel/pid.c
> index adf721606768..4f9a29eb29de 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -893,6 +893,13 @@ static int pidfd_getfd(struct pid *pid, int fd)
> =C2=A0	struct file *file;
> =C2=A0	int ret;
> =C2=A0
> +	/*
> +	 * Require the target to be visible in the caller's pid
> namespace,
> +	 * like the pidfs ioctls that grant access to its resources.
> +	 */
> +	if (!pid_vnr(pid))
> +		return -EREMOTE;
> +
> =C2=A0	task =3D get_pid_task(pid, PIDTYPE_PID);
> =C2=A0	if (!task)
> =C2=A0		return -ESRCH;
> @@ -917,9 +924,10 @@ static int pidfd_getfd(struct pid *pid, int fd)
> =C2=A0 *
> =C2=A0 * This syscall gets a copy of a file descriptor from another
> process
> =C2=A0 * based on the pidfd, and file descriptor number. It requires that
> - * the calling process has the ability to ptrace the process
> represented
> - * by the pidfd. The process which is having its file descriptor
> copied
> - * is otherwise unaffected.
> + * the process represented by the pidfd is visible in the caller's
> pid
> + * namespace and that the calling process has the ability to ptrace
> it.
> + * The process which is having its file descriptor copied is
> otherwise
> + * unaffected.
> =C2=A0 *
> =C2=A0 * Return: On success, a cloexec file descriptor is returned.
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On error, a nega=
tive errno number will be returned.
>=20
> base-commit: 44cc27050381e92de64cc3d7836376eda4d92a5f
