Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183858;
	b=Eb6nCLJMOfgom6fYUnp/heHMh0n5HdDoQeDL6xM6kAGGUq12pJ4Y0LvjDgREaXF6VMzN
	 lZZ52MBNBEL9FW2L7P9PySPYol69iu6beT83wpElwDZ4pd8QyZvDTrbwC72sXpQN0iGdl
	 yE3WscCva6lZi/aIbTJg/iDWdEtT1i0ny9LqIBMp7U1cHYGNvTn7V88dG3Zb0WbcCawkn
	 FJzwDUt3D2pEIwmsed8cqEXylLZFM4lOYGSoZdrfOjzi4Q0eqOqJL5W8LNaGCytU6eXFn
	 Uv63wSnOUKNLy867LLY6LNabYh30szN6WIcwcZ8GnRVcgHS0954tV0vUSvk8w0SCRGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=xdvxIbctXUQ0A6p+jo38RyjgMp4bn1ACclIQLuotDG0=;
	b=Z9Z5AaxJAfvdSU3VvS6UI71SFnYZUuOvcms7Oh6cwFeXAk9/GB/kQeGqnB0rLoZqM9YU
	 7S+tvGpe+Z656pse9908LzCPlledWhiIEsZHr4l9RONtw9Gfj2XiiV1wwKTMzSJ8LaBF9
	 Ns0UF/kQphaOc3IJ2dfdg30j+e3stEqeozNjfKdafINGehlrygWjrjhkGH9bZ6V/PLHZa
	 cPp86D4YVmy6056/266PuDlcTG85zdML9aAADfjZVItVKafnSAiCLHMuriQz1UKexEZaL
	 La5fYDTZRgjTAVIcoMT5f5fjmWmfYRoYtM8tkPWrha6OvJrKKeE9m+ZJzoTiRwMarJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Cmpsnf0s;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94576606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94576606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Cmpsnf0s
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so8221745e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795183856; x=1795788656; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xdvxIbctXUQ0A6p+jo38RyjgMp4bn1ACclIQLuotDG0=;
        b=Cmpsnf0sBqKrnRPX+kthnpkzYVJr8ds+zTRCLNR5vrfyV6wUuNRetBm43+z2ivyhbe
         7KIy1PLbvxWaG9vRJ67thbSzW8OHeWbuD18LWkHEsrFdpfGpjwwfAfOih+iZalcwQv/f
         scsKTDwLkc84RH9TNBl8FLs9Y47GtQtqDQ6NLXyemVnOWlyieGGSKqVqwsTVU7mePfdq
         7OZLgtjNk+1GUgl9K9D7TdKjKBcsOB3pnrrHInsceM1EvNkHj+rMUNsIi5zcT+xvcAOg
         66z+1AIm/V4tqDvE+MJS392q2MUvKaVO+Sfe62C6U6PwwrTRmMIoAMmkM458PVInHX4O
         jegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183856; x=1795788656;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xdvxIbctXUQ0A6p+jo38RyjgMp4bn1ACclIQLuotDG0=;
        b=058Y+0xD39qu9N4NdB5YXi+XhvFv+UrMHldNRxbPky8/7KMr/Nx9tKu1LADPOjykRl
         rcMQP16R1R4NfxaiUj7ddzBn4fC3fzjn8vjFPkxCOJaUDs64bHlz6czbVoA6Gg1164EA
         fqEb4Q/CnNTwJMOpIKOiSEawFIdF+EkQm9ol6igLrwyax1hl2VseIWJqMzFtSnxk41vJ
         9doX39AFKb+pXWr4vfWup5FckZjh8Xg1FnD8BgGTH9rIslQvwEftKHeYolLEGEsf6QwZ
         n7uYoQYQ4HIYGZq5a1nKcNkT0RxynQCt4wxK8vDmXLW6dsdDfR4cHryXUmqRd2kh5vJs
         NH1w==
X-Forwarded-Encrypted: i=1; AL+hErHTGRnFNG21MPKmNBuv2VG2+jddVz7dULtCjk+q8fm2HAXXUk4rWCqAZI35MiV/nQ0AJCOJhNs7WKvG4Cra@vger.kernel.org
X-Gm-Message-State: APuU4Z+9JPLoyreG65X1lC4Kx56YCKK6bCBrmrqgmWkjDmdb4bTSImJX
	OyQ24E8UgGSMG6OKuYMwG+i1aJnjMzPod3z4E+WtXd/SXI+HEeooBrGoFUPcp+fghWmG
X-Gm-Gg: AYBFou0eVLNUkLO2yt2wvt5Gj79f419h6NGhx1mhN25ReYz94ELVS7q1xeFqFGE2ZPX
	uO6eXvyvLcJPuLlOhJ7spu4FVgFEby285jXjtEDoHaVJD+pMCINLOMPid/eBr+8Dk7k/VfEkq3W
	65UaM8BhYL71W2pv2SmI4E70dGINKDLvfnmCIE9WCrU66JCOX8peNkb6IZY/UIABCcIYvVG9not
	5ADszykAsPe/T3rv0oRA319I0s3lS4GdiuZ72Qn8PfquRujOD0CjHhiBHdxUCDmsZPOVX1Z8+C0
	v2FDKdg/ph/xOOdmQQ4I4cfoJfsk8DPxhOfdMvi/SV5Js7GVHxawbYh62EzKGJzBoWsWYLMU00Q
	A3HhJz2fEE5nZEvq+FBkY0xtI+X8IG3tn+mDs0OtJ3Qf92Bz3LLqoVD6DQhC29ektm0mwqI9avj
	PKasve5qMUH/V94bW+QcBdWEHrQhxNOwqkdDbF/8ADd0y/LAoBSZCUDQL70sx0EA3AxK1ypXgWs
	9KSqHTdDkfgmySQqy5w+rH1TicrjC+zin/t1biQGOk9uUR2Q6MEb8KTIFAVVxiwVxT1opb7VbUJ
	666DeTXSv2ToEJRny46aljtzql5ZeI9bANP573AhCUcqheY6LimcgaeNSW3jHkueZg==
X-Received: by 2002:a05:600c:1d8c:b0:4bb:5345:606b with SMTP id 5b1f17b1804b1-4bb8882358dmr73891225e9.31.1795183855925;
        Fri, 20 Nov 2026 06:10:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm136973405e9.3.2026.11.20.06.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:10:55 -0800 (PST)
Message-ID: <60078f93cf307f3040b4913bb94b2d73798b4471.camel@amutable.com>
Subject: Re: [PATCH 2/3] pidfd: convert remaining visibility checks to
 pid_in_current_pidns()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>, Jiwoo Kim
 <arpe1618@gmail.com>, Chen Linxuan <me@black-desk.cn>, 	linux-mm@kvack.org
Date: Fri, 20 Nov 2026 15:10:53 +0100
In-Reply-To: <20261120-work-pidfd-pidns_visible-v1-2-0e82d08469ae@kernel.org>
References: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
	 <20261120-work-pidfd-pidns_visible-v1-2-0e82d08469ae@kernel.org>
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

On Fri, 2026-11-20 at 14:42 +0100, Christian Brauner wrote:
> Switch the two remaining open-coded visibility checks in the pidfd
> api
> over to pid_in_current_pidns() and drop access_pidfd_pidns().
>=20
> pidfd_getfd() uses !pid_vnr(pid) which is the same check as explained
> in the previous patch.
>=20
> access_pidfd_pidns() walks up from ns_of_pid(pid) via ->parent until
> it
> either finds the caller's active pid namespace or runs out of
> parents.
> pid_in_current_pidns() instead looks directly at
> pid->numbers[active->level]. Both answer the same question.
> alloc_pid()
> fills in pid->numbers[i].ns with the ancestor at level i of the pid
> namespace the pid was allocated in, starting from that namespace at
> pid->level down to the initial pid namespace at level 0, and a pid
> namespace is always exactly one level below its parent. So
> pid->numbers[] is just the ->parent chain of ns_of_pid(pid) laid out
> by
> level:
>=20
> (1) The pid was allocated in the caller's active pid namespace or in
> a
> =C2=A0=C2=A0=C2=A0 descendant of it. The walk reaches the caller's namesp=
ace and
> =C2=A0=C2=A0=C2=A0 succeeds. The caller's namespace sits at active->level=
 <=3D pid-
> >level
> =C2=A0=C2=A0=C2=A0 in the chain, so pid->numbers[active->level].ns =3D=3D=
 active as
> well.
>=20
> (2) The pid was allocated in an ancestor of the caller's active pid
> =C2=A0=C2=A0=C2=A0 namespace. Then pid->level < active->level,
> pid_in_current_pidns()
> =C2=A0=C2=A0=C2=A0 fails right away, and the walk only visits namespaces =
above the
> =C2=A0=C2=A0=C2=A0 caller's and ends at the initial pid namespace's NULL =
parent.
>=20
> (3) The pid was allocated in an unrelated pid namespace, i.e.,
> neither
> =C2=A0=C2=A0=C2=A0 an ancestor nor a descendant. The walk never meets the=
 caller's
> =C2=A0=C2=A0=C2=A0 namespace and fails. If active->level <=3D pid->level =
then
> =C2=A0=C2=A0=C2=A0 pid->numbers[active->level].ns is the pid's ancestor a=
t that
> level
> =C2=A0=C2=A0=C2=A0 which isn't the caller's namespace, so pid_in_current_=
pidns()
> fails
> =C2=A0=C2=A0=C2=A0 too.
>=20
> With CONFIG_PID_NS=3Dn everything lives in init_pid_ns at level 0 and
> both checks trivially succeed.
>=20
> pidfd_send_signal() keeps returning -EINVAL for an invisible target
> as
> that is existing uapi. pidfd_getfd() keeps returning -EREMOTE.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0kernel/pid.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0kernel/signal.c | 23 +----------------------
> =C2=A02 files changed, 2 insertions(+), 23 deletions(-)
>=20
> diff --git a/kernel/pid.c b/kernel/pid.c
> index aa3ed6b5d4a9d..72b98d0f35ab1 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -918,7 +918,7 @@ static int pidfd_getfd(struct pid *pid, int fd)
> =C2=A0	 * Require the target to be visible in the caller's pid
> namespace,
> =C2=A0	 * like the pidfs ioctls that grant access to its resources.
> =C2=A0	 */
> -	if (!pid_vnr(pid))
> +	if (!pid_in_current_pidns(pid))
> =C2=A0		return -EREMOTE;
> =C2=A0
> =C2=A0	task =3D get_pid_task(pid, PIDTYPE_PID);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index dd770e68faee0..2c2907d969485 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4045,27 +4045,6 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
> =C2=A0	return kill_something_info(sig, SEND_SIG_NOINFO, pid);
> =C2=A0}
> =C2=A0
> -/*
> - * Verify that the signaler and signalee either are in the same pid
> namespace
> - * or that the signaler's pid namespace is an ancestor of the
> signalee's pid
> - * namespace.
> - */
> -static bool access_pidfd_pidns(struct pid *pid)
> -{
> -	struct pid_namespace *active =3D task_active_pid_ns(current);
> -	struct pid_namespace *p =3D ns_of_pid(pid);
> -
> -	for (;;) {
> -		if (!p)
> -			return false;
> -		if (p =3D=3D active)
> -			break;
> -		p =3D p->parent;
> -	}
> -
> -	return true;
> -}
> -
> =C2=A0static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
> =C2=A0		siginfo_t __user *info)
> =C2=A0{
> @@ -4186,7 +4165,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd,
> int, sig,
> =C2=A0		if (IS_ERR(pid))
> =C2=A0			return PTR_ERR(pid);
> =C2=A0
> -		if (!access_pidfd_pidns(pid))
> +		if (!pid_in_current_pidns(pid))
> =C2=A0			return -EINVAL;
> =C2=A0
> =C2=A0		/* Infer scope from the type of pidfd. */
