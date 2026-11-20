Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183844;
	b=m6KUldrKmAY3rUeF+/pahlnkVCD5mJFHBeibaPOSqXft+lMxQBMSe/hP5R7FiAOwzzLp
	 bhPVkFfdr20uouVy1S2GG0oY/nVOYps6gXkK7yQx6VnnVxr/8prjEruNQ6+SHu+ySkD3h
	 PzXkAygMf5YiFaQaqP61Vlh2jFSuTK+G+s5jy3kRMXAfvgNe+SPrDGiFQ3ESnkRs2yekI
	 DBY7cloE6u/XrNCWB+drIgxGYGoyncNiput3H6DSqb46RB1pomsyc+9P7LTOwl+FEEgQF
	 /+Vvqb1N23+HL4j6jiJoaOIX3uP34eGevWiT61gd7UzHnPknsouDACttMrNZbm4rvwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=A93guMQx13afloHMQAdIu6HoaXjBTOUttW4FwRn2JXg=;
	b=q5D/Qtm17mUpzgVxl59kgi1RD41sqLHX+2xaEyIr1G38p4QTTOo1XaRpISVqXkuZoag4
	 jMlJvd3Pz2dlH67NC8OzwO0HkAkofpc9K0RvD9PSQzoXeiDHgS27hdlotzLIvLFDBEWUe
	 HvBo0VZZ1SzM2PmJHX7im/xMPP2qjnf619GPn62FeVEfmb56dBORMgVJpi9LpdnarESDB
	 EzK/4pya9hiTOZ0eEgrte+fWg/EJaW0B4Bxpz/YFVQ5wMIEf0c6ohx3GloFpvvZABIRzH
	 AoeNWwgw0IQYivbhUKcpFsRlKicDcCUpWZnfAiRN5QnTza1gTfr3W37zclOOesVM0PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iZRRwSGO;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556660A260A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E556660A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iZRRwSGO
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49465892f7bso746825f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795183842; x=1795788642; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A93guMQx13afloHMQAdIu6HoaXjBTOUttW4FwRn2JXg=;
        b=iZRRwSGOBkguM/7W5m7kM49os9K2S0r3mo32Tp8oIMDwbdljIqiFRXzmGw5Q6Q9IVP
         q/wz90fZh8LHnnANIsME7VuE09wP5wcuYnd0/Srrr+gtqJRb0B0NzW4Wt150jLW/TG7I
         t58BFYbUBSf3OA0+971b5JS87D6cKSyAU7FZzpSByMFsC7033mEfvvOCz8R1Vjb4XWwB
         WVyurH7H0xcDkm4/MBbTagZjdegq6lHPLxcXR1tOrV/6Ozmm1RgB6LmzVn0Kj//XWJ4J
         otOvAPRiGgz+4a+CvGhNI9yIs7VNlsMoiKI5y0hDrNoDDVM8lu5KWjdKoYAddDdiFVpU
         WZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183842; x=1795788642;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A93guMQx13afloHMQAdIu6HoaXjBTOUttW4FwRn2JXg=;
        b=D5xma4u3O2Y40G6UAwAkZpqYBWErZDvYY4aHO7jleRolEk3D/KM6iPTvJ8x65OmZfS
         fMSUnYCXgBsV3wRqb8QguhRsJBHvm8OyGD7n8nzlYGOwwp3T5kWeI0mhBAgzqfQw27mZ
         H/Bj8iss6n6WxjT9KMPQV/DRLC6YGPNd7XfyDb6isFLvyVmRAhg2hsrFPPfpyc1wJL3F
         hxpJG5bBYlwlVXElpmoO9odQ8nbI17bWqbQ8rBVnNzhnFmWGKdZhqngKx1+kHTJT0Laz
         KDeQ+4G+BoBy3ctBzVpZ6GLJmh6yy1aEBKgUsS/0nj7kE5rFaRe20nJwr2iJsKRuYxn5
         zZkg==
X-Forwarded-Encrypted: i=1; AL+hErHElIaDnlD3iFtP8pjnRuBWv5Zl/2ocQAZwspumSMmbKK01AFAseO+fLve4e0og0l8cM/0Knh3F7HnXi01J@vger.kernel.org
X-Gm-Message-State: APuU4Z8CU/jqGcpoLWEJkSqBeR48XLll6FvBz7OQjuPJQIUlSQEsATwo
	r1sq3lDCoXt01NPaoGtUYEI0Yww+RsWJit0/kRz9E+o7nj9SFrMjgSKZ0ZbRd/O94iGdMLKFaHh
	PCOCbIfW7
X-Gm-Gg: AZFdTZd+C4NKUEo8Uuj0L1XHN2AL6gpDdJlfU6/ZQJ1dmoC5z0DlSBfCmlBbe9UkuEd
	pcgOijZnbwO5GbjsjkXSXAAR9HaFFQyGQz2Q3g3/o5/bLxCmGbnD3quOcB5FK1FgHr+kJsICWWy
	mOyzUrAHC3GWalHsfMW8Q/UL+1SIuA9cGk21O9dtW75Bh3bqwcMgQYlqtFMQzG1NwskdSIveIzj
	U03zAUUGI4HLaNuw5CzUAMQG4MM9uknIiSXsgZwu74miO/upmrAqbXR3/QnAadZsq/TnRKFu5Wv
	pjMFnNlpCKg5DVeUjiX7U/m10razYbCRwkrQiYcW1WNhf8F1aq+DX38RM/cQzgziwnNd8dA7Wql
	wbGZGby1RprpSlBmmjr9XrFpb9kmY5Ilvqsh275uOA4PDICAygX2CFfe23bR8CqZgfq8gK6zEqk
	PNwKoDLLbLUGOz04keD44KfGm2YORo0FbbIJOqyGFJRImQ7Y/iwzIuYFmS9AbeQhmnjjbHjIlNi
	gbdFPq3FSf+qx4o7n58QC4FgCtkTPol6ioqXJAEzJYpN/ua7HmTYod+IpzyI+T3/TjrCD2Hfwf3
	Hvnyuj5UCG70AiNNceartJ7bJC3kIU9vMK8gs28lli43daF9LNAVoLi67xEvqa82kg==
X-Received: by 2002:a5d:63c5:0:b0:48b:4a2:8175 with SMTP id ffacd0b85a97d-4abb4e64383mr4811907f8f.43.1795183841815;
        Fri, 20 Nov 2026 06:10:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm1875255f8f.17.2026.11.20.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:10:41 -0800 (PST)
Message-ID: <c80029503d191c086fca17d42e78d99604cc1311.camel@amutable.com>
Subject: Re: [PATCH 1/3] pid: move pid_in_current_pidns() into kernel/pid.c
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>, Jiwoo Kim
 <arpe1618@gmail.com>, Chen Linxuan <me@black-desk.cn>, 	linux-mm@kvack.org
Date: Fri, 20 Nov 2026 15:10:39 +0100
In-Reply-To: <20261120-work-pidfd-pidns_visible-v1-1-0e82d08469ae@kernel.org>
References: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
	 <20261120-work-pidfd-pidns_visible-v1-1-0e82d08469ae@kernel.org>
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
> The pidfd api checks in various places whether the target is visible
> in
> the caller's active pid namespace. pidfs has pid_in_current_pidns()
> for
> PIDFD_GET_INFO and the ioctls that hand out namespaces and task
> paths,
> the pidfs file handle lookup uses pid_vnr() directly, pidfd_getfd()
> uses pid_vnr() as well, and pidfd_send_signal() walks the pid
> namespace
> hierarchy in access_pidfd_pidns(). That's all the same check.
>=20
> Move pid_in_current_pidns() into kernel/pid.c so it can be used
> outside
> of pidfs and convert the pidfs file handle lookup to it while at it.
>=20
> pid_vnr() returns pid->numbers[ns->level].nr if ns->level <=3D pid-
> >level
> and pid->numbers[ns->level].ns =3D=3D ns, and 0 otherwise. That's exactly
> the condition pid_in_current_pidns() checks. Pid numbers handed out
> by
> alloc_pid() are always >=3D 1 and only pids allocated by alloc_pid()
> end
> up in the pidfs inode hashtable. So pid_vnr(pid) =3D=3D 0 is the same as
> !pid_in_current_pidns(pid) in the file handle lookup.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Ha-ha, this is exactly what I was thinking about when reviewing
https://lore.kernel.org/all/20261117152332.1221-1-arpe1618@gmail.com/

LGTM

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/pidfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
12 +-----------
> =C2=A0include/linux/pid.h |=C2=A0 1 +
> =C2=A0kernel/pid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++=
++++++++++++++
> =C2=A03 files changed, 23 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index a2a0691cf1310..85b160923177c 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -327,16 +327,6 @@ static __poll_t pidfd_poll(struct file *file,
> struct poll_table_struct *pts)
> =C2=A0	return poll_flags;
> =C2=A0}
> =C2=A0
> -static inline bool pid_in_current_pidns(const struct pid *pid)
> -{
> -	const struct pid_namespace *ns =3D
> task_active_pid_ns(current);
> -
> -	if (ns->level <=3D pid->level)
> -		return pid->numbers[ns->level].ns =3D=3D ns;
> -
> -	return false;
> -}
> -
> =C2=A0static __u32 pidfs_coredump_mask(enum task_dumpable dumpable)
> =C2=A0{
> =C2=A0	switch (dumpable) {
> @@ -1028,7 +1018,7 @@ static struct pid *pidfs_ino_get_pid(u64 ino)
> =C2=A0	if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
> =C2=A0		return NULL;
> =C2=A0	/* Within our pid namespace hierarchy? */
> -	if (pid_vnr(pid) =3D=3D 0)
> +	if (!pid_in_current_pidns(pid))
> =C2=A0		return NULL;
> =C2=A0	return get_pid(pid);
> =C2=A0}
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 185bf0cde2d14..1b463921d2ed0 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -239,6 +239,7 @@ static inline pid_t pid_nr(struct pid *pid)
> =C2=A0
> =C2=A0pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns);
> =C2=A0pid_t pid_vnr(struct pid *pid);
> +bool pid_in_current_pidns(const struct pid *pid);
> =C2=A0
> =C2=A0/*
> =C2=A0 * Needs tasklist_lock if type > PIDTYPE_TGID. A lockless reader
> can:
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 4f9a29eb29de7..aa3ed6b5d4a9d 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -559,6 +559,27 @@ pid_t pid_vnr(struct pid *pid)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(pid_vnr);
> =C2=A0
> +/**
> + * pid_in_current_pidns - check whether a pid is visible to the
> caller
> + * @pid: the pid to check
> + *
> + * A pid is visible to the caller if it has a number in the caller's
> active
> + * pid namespace, i.e., if it was allocated in the caller's active
> pid
> + * namespace or in one of its descendants.
> + *
> + * Return: true if @pid is visible in the caller's active pid
> namespace,
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false otherwise.
> + */
> +bool pid_in_current_pidns(const struct pid *pid)
> +{
> +	const struct pid_namespace *ns =3D
> task_active_pid_ns(current);
> +
> +	if (ns->level <=3D pid->level)
> +		return pid->numbers[ns->level].ns =3D=3D ns;
> +
> +	return false;
> +}
> +
> =C2=A0pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type=
,
> =C2=A0			struct pid_namespace *ns)
> =C2=A0{
