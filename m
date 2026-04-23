Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CAC36492A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933895; cv=pass; b=i+eYSiIEIx4EdWf6ZldV6yYMFpeLGycNPjyDYhNUbHkoynAa5UT4W+Q6+nGB2Nl4/2i3ODaYA9bceHo8VAK4gkaBFyu73vd6N1ALNYf/bbnh0qn0+rvzYCKkLbtqwUB4gXY8bW6fY9GjKy41pEBm+cAE34ovHGkus2DAULFvbOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933895; c=relaxed/simple;
	bh=BkHQvLayOxx925RpqmFBcGRh5pDK2pwDTGlSpcMw9yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuzDKgeyqjWeuoeKTmZnH+wNMtrfzMLdOBtFTQcrjk+p0V54sHGTHhZCwBQmE/dFBVCBUa49liCywW1me3foQXSrvVyNl7+dtjDbidfGdZzGtaF6ryK+X/++oo0MkWCPLcUxKAmO90/wMqdA8oBRp3JRA/T8PInJPBO+aCWcQIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlOQbGCM; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlOQbGCM"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso921764866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 01:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776933893; cv=none;
        d=google.com; s=arc-20240605;
        b=CoA34GCBWtW/r/wsAZvFbtbIrqMrqK228ND9uI1Ak/jgMd43xNpGVb26HO4kkljUgV
         9VUlTEBXNDUFE4ZeIv+QJ1bqIqStDwjDxE7H3FYAatQcNsCKcaOCHoGkTqcWok2mkiKx
         fTNCyJau93gKBLQwKmYjAwOXRLf35SvGC0u8bsFZ5QTDnNBgqAIudeZbO3fxjmVFonl+
         nz5/qN5/h4pNFLrpOcDx+wlcqoPyfs2pjuMZj5S/ZgoD8VkBcYyNkGuMCerRxONAyity
         KSbkFcnBJjx5zPps8f45mzqofEWzoVDz3q1HMvUGeKi51cQ/jA2dlA57JIz8d5MN9vyz
         oaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cr2DxCftNoLGV0XgJFquO+Wug9SkaXdAg2c0Mitnj8A=;
        fh=XaSVZY6cwbAfADeBZbrEt61FspkjU09SmPosZcQ+aeA=;
        b=Ja3ThE7lEd76ZcsbQzJXiCdkVuGHmviuiU5ktSjruUXxugwOJEWLViyL8u9fNoyD/K
         xPY/fI/xhAbqoSPwBdiHHS0/aH4qLBn940OVLH0/qOcHLPGY0U6bd8OX6pvWajb9SE/x
         zJ0D8VPBkYxtXpD9sqfoVA6+coEsvickumpA0USByc5vEYQQu/F79M6T2+/tpvmzpLGl
         ozy5AS7AkfmSeugyhisPPwbTVll9V2U9g4oYL3oojqGmvp47MyedBZh5vm5eSak0A954
         R0RVwgeI0V6EVv15kWJaf7HxmkTvglUkOH2qFYmsJZq0jNn27XyFcJaI8VexGIGGoyTa
         GvNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933893; x=1777538693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr2DxCftNoLGV0XgJFquO+Wug9SkaXdAg2c0Mitnj8A=;
        b=hlOQbGCMn+QoYeswiujVFHFNxherkFoV2OI6z3ErU+dyNVljXc5OB/Q5OA09qEJJGj
         HshcQz3IZAcJSBeviFPR9cDn8RnobdIwjb4FmQCL9/BTN+kkwBdCcb7T7RWdl2GW0S8S
         qEkMiXcleMxu6kiz/9X26qzrldgFJ5V+vMjjjR3NunMsyoytAdB+NJa4CxKpvwgOo3Fp
         B4VSOLr4xXeVxGE8SllRSqteW36TArkpOEk5IWacy7HGWxldWLazH0wT3OvMPf3lGkPp
         UjjHc5FaJfz4yy7JMrvtwSn2FZzXtiBKvYVcoIoDg/yvcRm2QAIUN+z7lk0l4NCLXQzc
         BUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933893; x=1777538693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cr2DxCftNoLGV0XgJFquO+Wug9SkaXdAg2c0Mitnj8A=;
        b=Tni/jnMzwo+ee9sDFEeKgN/4g9oW2StV5Ik51GY5XQbh+q3ftowGgvwGEz1WAvkkqW
         HyNHfMJcCuxjirl9P4FiheiIQpfFR/ZS43BQlg6XdyheC7qjPhlSN1MtrFuz1bfRvL7S
         JQZXp4KavMIzOItavk69l6sqz5XsrtsqXumv55c/dF8wrlHuaAFtbqHOyl/79Bn16ui0
         XOVaiTMXhPWPyJBpYyQ+uBRSfc1C9OF2IuVBZMS9XMgfMG069CKUMVWMqjUbOxWMeEgc
         dAFt3nBrc9uVfB2cSASc/AXVOaL9JOm87xD3d8d7dpvODx4ZXBGxOyq4qcd4NznS89CO
         GAqA==
X-Gm-Message-State: AOJu0YwK16n68DpzI5RML5WCfvRG2Cy0FZvz246/rRGY0YvrxZdgGSR8
	YbOfBkY86zcZy9CesHquQRIQUtnsHHsUjzq+yp6YyLHsYP191l67rW0PmcJpa0cOY5CN+bWPkMj
	T1lfNayYBL+icHUP3+RhcEiiUlPPZOng=
X-Gm-Gg: AeBDieuPIQKEaonyUxIro7WyVTbRHI9GfF5pbk2aVQhK47FDlw+XVmDUbxHhEvjVSg0
	BQdzELQgjOmL178qK+UZvF4uPsBbM0MTyL97BZOrqiegzyNcty5/Oq78YIhxerDLmR0+dVzfSET
	Ul0mcD740VqN4KEHX3ZaQ4wBzmj+U5UPEX6k9eoBsf8eeZa0zRMtMEamCatFwdlfY/2KIRpcI9V
	3uizsnfhXKdOIoHQldCR0hhWISwi21PqB+/5ds/Bbn8PDWzOJ2LmsnBBXI24POQsqVJQe/lSW8y
	viukP9Q61/SJAHTP2JfMyLUQvPsS/l/7OklMeU8NexOt6NfN+AL8
X-Received: by 2002:a17:907:970a:b0:ba7:9885:b56e with SMTP id
 a640c23a62f3a-ba79885ba4amr816855366b.20.1776933882752; Thu, 23 Apr 2026
 01:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422231518.GA7717@frogsfrogsfrogs>
In-Reply-To: <20260422231518.GA7717@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Apr 2026 10:44:31 +0200
X-Gm-Features: AQROBzDxnRHLctVJUca6bIp8OO4TE6wlUznX6wKwx0EA_yNWOAIcr1mgvh7h0ws
Message-ID: <CAOQ4uxhEmbFWuM80F+Tq7TbDWjrL-znkwu=O=P7Ng2P5dksXsg@mail.gmail.com>
Subject: Re: [PATCHBOMB v5] fuse/libfuse/e2fsprogs/etc: containerize ext4 for
 safer operation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	fuse-devel <fuse-devel@lists.linux.dev>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>, Christian Brauner <brauner@kernel.org>, 
	demiobenour@gmail.com, Naoki MATSUMOTO <m.naoki9911@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 1:15=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> Hi everyone,
>
> This *would have been* the eight public draft of the gigantic patchset
> to connect the Linux fuse driver to fs-iomap for regular file IO
> operations to and from files whose contents persist to locally attached
> storage devices.
>
> However, the previous submission was too large, and I didn't even send
> half the patches!  I have therefore split the work into two sections.
> This first section covers setting up fuse servers to run as contained
> systemd services; I previously sent only the libfuse changes, without
> any of the surrounding pieces.  Now I'm ready to send them all.
>
> To summarize this patchbomb: fuse servers can now run as non-root users,
> with no privilege, no access to the network or hardware, etc.  The only
> connection to the outside is an ephemeral AF_UNIX socket.  The process
> on the other end is a helper program that acquires resources and calls
> fsmount().
>
> Why would you want to do that?  Most filesystem drivers are seriously
> vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
> over almost a decade of its existence.  Faulty code can lead to total
> kernel compromise, and I think there's a very strong incentive to move
> all that parsing out to userspace where we can containerize the fuse
> server process.  Runtime filesystem metadata parsing is no longer a
> privileged (=3D=3D risky) operation.
>
> The consequences of a crashed driver is a dead mount, instead of a
> crashed or corrupt OS kernel.
>
> Note that contained fuse filesystem servers are no faster than regular
> fuse.  The redesign of the fuse IO path via iomap will be the subject of
> the second patchbomb.  The containerization code only requires changes
> to libfuse and is ready to go today.
>
> Since the seventh submission, I have made the following changes:
>
> 1) Added a couple of simple fuse service drivers to the example code
>
> 2) Adapted fuservicemount to be runnable as a setuid program so that
> unprivileged users can start up a containerized filesystem driver
>
> 3) Fixed some endianness handling errors in the socket protocol between
> the new mount helper and the fuse server
>
> 4) Added a high level fuse_main function so that fuse servers that use
> the high level api can containerize without a total rewrite
>
> 5) Adapted mount.fuse to call the new mount helper code so that mount -t
> fuse.XXX can try to start up a contained server
>
> 6) Cleaned up a lot of cppcheck complaints and refactored a bunch of
> repetitious code
>
> 7) Started using codex to try to find bugs and security problems with
> the new mount helper
>
> There are a few unanswered questions:
>
> a. How to integrate with the SYNC_INIT patches that Bernd is working on
> merging into libfuse
>
> b. If /any/ of the new fsopen/fsconfig/fsmount/move_mount calls fail,
> do we fall back to the old mount syscall?  Even after printing errors?
>
> c. Are there any Linux systems where some inetd implementation can
> actually handle AF_UNIX sockets?  Does it make sense to try to do the
> service isolation without the convenience of systemd directives?

A large part of the world is running container workloads on kubernetes
and my understanding is that k8s does not mix well with systemd.

We have successfully used the fusetmount3-proxy [1] approach by Naoki
MATSUMOTO as a way for unprivileged containers to delegate fuse mount
by a (non-systemd) service, running in another container.

[1] https://github.com/pfnet-research/meta-fuse-csi-plugin#fusermount3-prox=
y-modified-fusermount3-approach

The README says that sshfs, s3fs and other high profile fuse fs have been
tested with this approach and they do not require any rebuild.

So it bears the question...

>
> d. meson/autoconf/cmake are a pain to deal with, hopefully the changes I
> made are correct
>
> I have also converted a handful more fuse servers (fat, exfat, iso,
> http) to the new service architecture so that I can run a (virtual)
> Debian system with EFI completely off of containerized fuse servers.
> These will be sent at the end.
>

... what is the added value of rebuilding those packages with systemd
service support?

I am not implying that there is no added value, I just am not well versed
in the world of container and system services.

Thanks,
Amir.
