Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8AE296BCB
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773755109; cv=pass; b=HPxMTjxYHGRy8/8c0GZ7unmIwcqZuw7Nq+G+/a5zOypBhUfIszQo7gwcpylxZHED4hdvCFnkFiToxq+P6ivnRwoBBUMFUI37kwAaZV30jUK2WRR7x4b9RDDlzQumYDLh5n/N58VaTBsg7kuOD8bsSrxE3hzrO9lVBXtNUfsJcXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773755109; c=relaxed/simple;
	bh=bNkUxyiNMUHjfYkvM9CVWkyjPH6djBHc0TiewNB75LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/Iw/91oe5INnmDXmF402/0SJKKtnu4AlHWpsEtB5aCNxE49oqe8Y/5sC5pkmL5YQM55KSjcWkQUpVk+VDSFG5SjQJt8LdU28lOSnGlxqbJcu0gb1j8r1/laJobC00j1tvCvREND1O/qKLCoB3/o6Fd+Cuck3R1T7zTNiEU5BE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKZClTrk; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKZClTrk"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b886fc047d5so961336366b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 06:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773755107; cv=none;
        d=google.com; s=arc-20240605;
        b=P8ECMLL+iwJioMimhaUtpoFSh9uTRJfPdj6Hvg6QY42cK6bpgPjRTHAQpCTzSXeZk7
         iMhcrCORu0TM/Iwlp5b9FHsthT4AMzeqZHrteF9j6t/0Eut3JhcEwDG85OX9fMQ09va0
         M/ZliO17Uvo6tv0uCrnCIDAX+rRj+2d59+uCHp0WPie2Y8RqmsmnRAC1TH3qmUfUWuFc
         rCIYcL4NgWaXmX85LbF1aUoGRXsli91RdtwRlHgxlAUE0C/VRw+XX+rq3zuDyjFugOBK
         CiuiTbRjve9XM4KtKg2MRhKkI1uqAr+zzkOqGVb1VdfNpoTOLffC4rGRV3emgev+Va3B
         m4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h2f6/whviHNj8OK8xn3S6quCgMDZrvi9L+k4voYVFYk=;
        fh=t7m29kz2JGY3pLbju7bed70M1eJhcjq7Zn+vWTMii/Y=;
        b=WYVWJoiEeQ5WlX+bAq6cUNqKCp/y0FIErGVsveG9Fb49AReeV+sDC7jAHgQAh4LECN
         U68VBS9zxki595WGUF+v1sv5ypMtDosVRXrdCDbjMirnCFRoSB8L1zU4P2yFEmq0m9s6
         H8791erfQous5jTSFMBcXvZPaKDt3pXubjyGuBCJxUnDKUmsxm5A32RS5MBbQxjngucg
         lB66Y40Elfx+22UXUvnNVJ5kMyJ7oZg+o86+wFi9o6pxKBgRIz4OWMEhM9PQ8/cJDzwv
         Mkiw2C2UEJqkSKRior6p/S5DME2Ftb1jp5v1nSTZ3Ldh13B/LirVFpYvWtzC2AB+CCoq
         7NJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773755107; x=1774359907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2f6/whviHNj8OK8xn3S6quCgMDZrvi9L+k4voYVFYk=;
        b=QKZClTrkBceqNdtRmmv+RZxHmuhYp62bU9VxvGQU11vmF+zKb3TFitfM8zbDBTs1/y
         bWfchRADdr2nDDgqb1n01C4Y8U84zFKipYlioecRm8MI2flXnW2ncCBNG/l0iBTEzW92
         dAZj8nJyAvcZ3PhIbuWr91sYrDWHR3ztJSTHBIzN7IaJyAX+HmlbDWcPG+gGI3kEibqQ
         KpImD169U77M0KE0Gj3yZXIhVWNMWLhDAlsB2Ex7RHOW7yTfUt+cN/G8cZLOlM5MilG1
         Q/QbuPjPZbhfctuIl9pvm6l1FkPZ4Mjwkv8U05YvCpSnJQ+K5ZfmkXtqn+U905xfGWEA
         DkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773755107; x=1774359907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h2f6/whviHNj8OK8xn3S6quCgMDZrvi9L+k4voYVFYk=;
        b=GakjRurHaZgyeKM5QtRiMlP8ogdRVYsQgjKVQn55l3bSzd5gTwmSHhqbCZZpXBWL6l
         ZWWGaZ+u9gu3GQKqKlHfYdZsjs8Xqu7u6utGdICEU0A7nVrWqhyShFU68TUrYaPPb+ix
         RW9L8Ln8K4wPsy73HZ9NkBlCWeoIE02nKWMyx19EOGmH/M5Q7Sin+bfo0d6n6tdpkP+w
         EdgHXPOrvP1QTQB8lEVdks7PV5ItXugFNotxm9H1hGtRoj/iGxpJw0iIhDbXv7vZZONQ
         6L4qt/bXixdbqPhTTy8GAs5INYEfaoGKOefpf4zBlBV3Bv8axDVeviIvrxhYm+Et0JQW
         eYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLpxyftxiUmy/ezUXkkhgelh9dcHG+QxylVNQ+JcRGrZsAUGe0z3qT5ydi/LXPAB5vpXkmc7eWtcgbVeNV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2RtlTL4WPpJwgkGnOFgXA7WXgBqEjQtDYDEwYTSt6oYKqe7b
	ALgYwWguoR09lCoKNEuG2+jQfszs4RTBBe7g1KaotgV6j/ezgFaG8R6imqUL8U5EmzGIrs7eUI0
	JmBRcHZmgN9x6vj8XKMyqevEFyO324ac=
X-Gm-Gg: ATEYQzx2T431Ge/k2AvAdFxSn+lyi9nE2rRkW1Fz3Nt7FAobcUgatVFeTPzX8G+wZEy
	XTxLEJFfj1fnxEymbF8PqeJbUJG6GSLI8NzmEOs017hyKcLssGF7UpG+QvVp3rXHdmvpH4YBV7W
	UVqh3HnKkRyAUtWiVgjM444iapgqeFBdHIe8EUcJn05QjapFPcz/ZyFJ2m7/2ydJXu0jKz1Ckmy
	eH2qO/v0N6NS8TGp0Y6/ED4WqChCcshCcLbGPdoO3Sz31kcUyvdILNtP/pUZWpPdUWsa2KSrOtg
	QyY6DC6uxqPV2Z1btrQwT3MMCXB3jDmiMQzljg==
X-Received: by 2002:a17:907:e8c:b0:b96:e3db:9e04 with SMTP id
 a640c23a62f3a-b97653cd9e9mr985932666b.53.1773755106457; Tue, 17 Mar 2026
 06:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316103306.1258289-1-mjguzik@gmail.com> <yojtdduvndkyez7mzyah2fznxtztf5boonyxwicp6zb6zw52ao@h6g6zcxhvz3w>
 <CAGudoHEMpe6r+g8OOhFPDAiHtVDraPxA4kSmVLp469g5YZgzYA@mail.gmail.com> <6mknq4cxnf2dhix23gv4wqxy3vnzmhy5opxwpd72ncnpdgnnxr@omhnt5rktvir>
In-Reply-To: <6mknq4cxnf2dhix23gv4wqxy3vnzmhy5opxwpd72ncnpdgnnxr@omhnt5rktvir>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 17 Mar 2026 14:44:54 +0100
X-Gm-Features: AaiRm53fUSuG56gzj2VpaPAVX5XnOKoobd_NDrMakaAomSkK_C2J99tek7itazg
Message-ID: <CAGudoHGQ1Bd0V2wcTRegKAzWqJqWX+CKX_gxF8bCGWQPXTo=ZA@mail.gmail.com>
Subject: Re: [PATCH] fs: revert insert_inode_locked() eviction wait change and
 explain why
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Lai, Yi" <yi1.lai@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 2:39=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 17-03-26 14:12:48, Mateusz Guzik wrote:
> > On Tue, Mar 17, 2026 at 2:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 16-03-26 11:33:05, Mateusz Guzik wrote:
> > > > It causes a deadlock, reproducer can be found here:
> > > > https://lore.kernel.org/linux-fsdevel/abNvb2PcrKj1FBeC@ly-workstati=
on/
> > > >
> > > > The real bug is in ext4, but I'm not digging into it and a working =
order
> > > > needs to be restored.
> > >
> > > I can dig into that. I expect ext4 ends up calling find_inode() from =
its
> > > ext4_evict_inode() handler or something like that? I was searching fo=
r such
> > > occurrence for a while but I didn't find it so can you share where ex=
t4
> > > blocked? Because the stacktraces from the original report just show t=
he
> > > journalling machinery hangs but those are only side-effects of somebo=
dy
> > > hanging in ext4 with the transaction handle started... Thanks!
> > all traces attached
>
> Thanks! OK, for reference the inode has been marked as 'sync' so
>
> ext4_evict_inode() -> ext4_journal_stop()
>
> ends up waiting for transaction commit. However ext4_new_inode() calls
> insert_inode_locked() with started transaction handle and thus waits for
> the freeing inode with the handle started. Classical ABBA deadlock. I'll
> think how we could sensibly fix this in ext4.
>

Do you think fixing the actual bug is viable for 7.0? The above revert
seems most prudent for the time being.

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
