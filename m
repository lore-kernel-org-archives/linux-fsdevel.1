Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793456299;
	b=pRj+HWvmwq7qjcCQ/Lo5Tgapb36Dci7UsqnI3cTYni5m9dpTmUChVd1vpt1ZRwF9zF7q
	 JN9IbmRzkrVrwwALClXvXTSTUcpBZSuE5LM2lUkVp6kiba7848mU+ZRpVgCmKN20UF33g
	 cEBgglywbwycHZLtsW5aJ994gUIXOdEX+09FoXk1LKpadFqcmMcYRT/4qUilKHg4wUMt/
	 A2e9xBT92z2EIadGRjs2+cBdjlsb9o8LNhUS4EPeQu0taN3LCJhr5IKqWYlc2kNYWxW9a
	 IC1PQEoWIhhgI+mKB7RbNHXAjzrs5Ip8g9H9F9j32+y1ydfpZ3lkZRB5NMXZdCUSlSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Patvq8zmYKObsZg0m1UZqbH1b5GBfytCkWtSbWUod8M=;
	b=aUfRAbAEtO/25qlXDD9NROkL13u0eIrJJscHMqa1KU1YminkWV/8DYxxst83A7xFszlC
	 IJ+n8AXo+oHKygldrI20vfY4dyE3kDgTc3fYPloS1FTQ9Fd1+HSxQicaw8clIuyLqFEb5
	 cv2Q8BbZsmcmXKzrREH/Rg32h0GuHRs9Rhkkb8uwzfCJKVIBSBILBtjuRumlQt5iyN8KY
	 OdI0crI3iaGdB7043+9DzSGlBUIR2S1A49TH9MXGGwB6us58DiR7FMy9KVt4g0ikCAp4i
	 DkphbqGpLnB6nr7fvJMEDMAelZFtJdGrlcAMy+zA7wskud1trgWSmPYy91/30vpgBxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oQSLLC1m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C3606A31D
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 14:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E04C3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oQSLLC1m
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so1587505a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 07:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793456297; cv=none;
        d=google.com; s=arc-20260327;
        b=DYLExHCRbJ6ZS3X38urZ9pPKI2vrQqZZT5MFBtCwWgMY5u+tDHCiaVDhN3kcoKwJRi
         3sCljgICKKBRCYsPlUnRJSKf4BW3jFdiUKM1qy12evsg1OGKvFsg+ZPoxoJEBTw1vKX5
         qzyKTxmU/TxFYos/PDxxWXYH9sxVI+7xqRWB0bfif5vIC6TFyDpdpqui1QWvpfBHHM6w
         s5E8f2vbV7K8jc2bUPewtnEPzPgar9mTriaKzNv4dqUeNU/ffdrlC4r74Q5yYYu2OA7a
         dvlcn8wwV1nqwvYQ/mjpqAyLpRPkcCR4RwN7Aln3Q6bZo3Tg08Pj/IAR0qSCbmKPSaH8
         x6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Patvq8zmYKObsZg0m1UZqbH1b5GBfytCkWtSbWUod8M=;
        fh=rBZ5iD3/3lvEynFiFwMsmMoCON9jlAWgGGTXCvwFmS0=;
        b=AkgxkslCfJNq5ST7LOvjIo1O8+6Wd9Vf4oaHYwbvPdZz3qq2C4KeyCbWLm1kGeRMuR
         ndYK5vVERIBSNuSbu6OXoXM/J1RQx1Jo736dBhPnkImLIaqdqQSan6SRZZcJnTQ9J3pw
         Pg92CX7wHh0BQGdiL2V24W5u7sMjbiq4saHRkr3bnBk9/GuTBHz0s4JwgmSvrvC2GHLj
         AeHA0oXDNQME7dnaaEtwkCv5FmeOHeYS9dl5Eh10SYov1r5DuvSU5PvInP3PVOKdwvCK
         Cp7XT76JNVLh5PbpNBUBSZY3pCIhnu1Ft38eupT8ueZGB/ZU93k+wupFAEVQ05ONBQ+m
         FSNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793456297; x=1794061097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Patvq8zmYKObsZg0m1UZqbH1b5GBfytCkWtSbWUod8M=;
        b=oQSLLC1mlwpZCk0ZZrL78sZBTbXMULvV3A5VNNAB+fjwScljqC/+c8krSIy+5QkCTU
         9Aewd6oLipaVsncWBwbOzv9IQ35Sk7bSNgHjp0q9Wh0a2M5YtJgfdFZMc6J+S9HU2qBT
         uw96KgDa0g49IduaTD9SDThtQLiSC3e2cy576lxjGXvJqx2nWlAIGE5JrjKqxNWqltIC
         LeoPRHoC4Uw6ELdtd0segJT9DnVtvGhpAZ9uPZfReqwNibJQV+/ySK4LD1s+LQDGz9h0
         4nHs5O8COquJdR38IVfmn3pvv/jXZZzJuRPfYpx/9C7z2hfBjbua015UnPZLfmLZJ2Xi
         1BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793456297; x=1794061097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Patvq8zmYKObsZg0m1UZqbH1b5GBfytCkWtSbWUod8M=;
        b=VkP1lDpvdOnl83Vyjod9flblEnIpsBI1os/u8BBUc0B/jyCeWWlVNMHNi6g3x4Mlqx
         j4wnrqiknQtsNEVdRFuxVXbg5g8Z1Osa3fN04gvXaua+c981Yi6bk6px6DEbFCfs3yEt
         fRrGD31E3JXSfu+kN+ZeWwzroSyUf3yTBUS2fECVO1zHoY1kWgdudnKRn4G5JwcDDtUa
         qqu6YnohatRaS03J2larJmaKIR4ITMqVxqJ49Jx46FR67nMufCc/ZeVUJMTtMkRnfmGB
         mqaWZFPnbevhCQjnh7RtakeSNe1nJ0v3bgFTJrYjwHdd2HSI3glyjrqWSUbBKwjhq54M
         kOLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqwcZW4OeoDMRmSXdJaDvcFH9tTcT3LPYCzZUbp3BLN8hTLG1cZ5bm9xCaC7r5nVez8PRHXSjGTnAe4jZ4@vger.kernel.org
X-Gm-Message-State: AFq9FYL7upzN95LaBPJuHXttq/nqKpaqEDSDLHY6tLBpYUEGXEyuLp/F
	oZkdpsdxq44cVFf4njyK3yltywP+bIU6n+NhWpDmHj4FRFH+4nabJFA7oDz0rINIzL9UwoVdpMQ
	t35EIu+BqweDhhHLCfuZIbTJ5D60vgbQ=
X-Gm-Gg: AYBFou2nhAxSIh4wqGKHzSNvo0P2dQxCqHZ58yUEzznnRmzXnI9MhEFXypsw3sO0vSc
	4hfCRNCRX5h4NWpxAFfLY5lk8xnIGUTOi1+vByjdG49AwA/O5XLJNlI8jmta25P2E+wGrD21Qf/
	N/XNOt/F0AyhjAdl0PHqvFeOAt5IxtG8UdnT3+q1l+cH9J+UhTIyaFmd84MStEcD1gdb3o5ttdZ
	AoV5iIyUdmKNW0PesXiKPnXg0JLHxzNCbTsU4zBr6FER20vlhKsPAYm0yVM/Irdm+8OIYL1oX7Y
	1XRyWRhkgmK6FiLr+5X9QkbwTbI+RFSFMuSZgcJuRltq6lR400ytSH+/JsiMCvBKRrqhA99Q4DK
	oJTRb3ft+hejuzA+tFKD1cEZL8cFHV5/wVcUIcTnhOP2u9b7SqfWt+TiBZ+JBQyddjOETqg==
X-Received: by 2002:a05:6402:50a:b0:6b4:5a0c:a7fe with SMTP id
 4fb4d7f45d1cf-6b4d4c72396mr3193898a12.28.1793456297060; Sat, 31 Oct 2026
 07:18:17 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028134728.294127-1-koray.fra@gmail.com> <20261028134728.294127-2-koray.fra@gmail.com>
 <auILs54TUcWXf3us@pedro-suse.tail5790ac.ts.net> <auMzpUIEmGCE_x_N@amir-ThinkPad-T480>
In-Reply-To: <auMzpUIEmGCE_x_N@amir-ThinkPad-T480>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 31 Oct 2026 15:18:05 +0100
X-Gm-Features: AclHuK_VupdwTnfkty2dMVhzMxaAc8BrZ6HJFAl7_OYvEEgnr1tOPYIrNbWdV30
Message-ID: <CAOQ4uxiuy0VwZj+3M-zRqQ49WTpHZpiaQ+6MZ8z8WdLjyQM_zA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] vfs: add provenance time (ptime)
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Chris Mason <mason@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Darrick J . Wong" <djwong@kernel.org>, Sean Smith <defendthedisabled@gmail.com>, 
	Andrey Albershteyn <aalbersh@kernel.org>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:53=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Wed, Oct 28, 2026 at 02:56:39PM +0000, Pedro Falcato wrote:
> > On Wed, Oct 28, 2026 at 02:47:27PM +0100, koraynilay wrote:
> > > Add provenance time (ptime), indicating the time when a file or
> > > directory was created. This is user-settable via file_setattr() and
> > > retrievable via statx(2) (using STATX_PTIME) or file_getattr().
> > >
> > > The semantics of when to preserve this new timestamp are the same as
> > > mtime, the idea being that there is a correspondence like this:
> > >
> > > ctime <-> btime
> > > mtime <-> ptime
> > >
> > > so every operation (copying, moving, ...) that currently preserves mt=
ime
> > > should also preserve ptime.
> > >
> > > Furthermore, in order to avoid the legacy FS_IOC_FSSETXATTR accepting
> > > FS_XFLAG_PTIME, add an FS_FILE_ATTR_XFLAGS_MASK mask to support new
> > > xflags, and use it in fileattr_to_file_attr()/file_attr_to_fileattr()=
 to
> > > allow ptime to be used with the file_setattr()/file_getattr() syscall=
s.
> >
> > Random comment, but: could this be doable with xattrs instead? I'm not =
sure
> > where I would put the xattrs code (if in userspace exclusively, or if h=
ooking
> > the VFS up with this, or if doing it on the filesystem side), but it wo=
uld
> > surely be less disruptive than modifying a bunch of filesystems one-by-=
one.
> >
> > This patch is quite simple, but changing btrfs, then ext4, xfs, etc is =
a
> > mess, and inevitably you can't get these timestamps until you upgrade y=
our
> > filesystems.
> >
>
> I disagree.
>
> I think that creation time should be a first class property in
> filesystems that support it.
>

One of the reasons that I think this API is a good match for the Windows
style creation time is that it was already discussed as an API for the
Windows style DOS attributes [1].

koraynilay,

In your next posting, I suggest that you first demonstrate how the proposed
API is used to facilitate filesystems that already support a user-settable
creation time (smb, ntfs,vfat,exfat), before adding btrfs support.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20241227121508.nofy6bho66pc5ry5@p=
ali/
