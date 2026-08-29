Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A2324B20
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787989023; cv=pass; b=DBAHLhiOOpgLAQzE2zRjwDUkxMaV6CQzfkUQd1tL6x76+QAKT3raqD/C95gUvLclm611Go4a7PiFyUj73zRlbLGQAdTEIdM70Mj+Pj+lyEJewjhMKHKbTeBnaAcBnc4n5ZT5lleTVuXYOEaDpmd2Rth32FOBEhrisJlw1EbU1IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787989023; c=relaxed/simple;
	bh=Sq0THEICTPM284NMNHXd2EjYwdjNxq1DooR5QncznmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCGxSHdWJwb7fPpb4w5jzroNAVOY0JBu5aMDuIKWQnsdywjf0bAxdCY5hEO4EZ1rUMty4JxaHoqu6O7q3qpZoLnm7MiOWjGyXI2EABd9bwZHuV3O0hirdG/j/aJ3aRMFoWBInUFHnUKq1+eCt6xiHi3ZTike5hTbDyllmWbP0QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=ZVWFMtF+; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="ZVWFMtF+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d8f265cbe6so2051575ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 00:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787989021; cv=none;
        d=google.com; s=arc-20260327;
        b=VKEDS+5DAtxf0hW0bHp1t6FIUM73/9OvmQ0VqD0pykRY/fvWMu+LFHhlkfIF7wnIb6
         965To2Az37QHQm58eohPhJ3V403fQ3F/6/b7ZgXjS5WC3VQuwujGlfhJHYR7I8Ae/J9T
         rCeQdckNzsClxtnmdsgKwAnKXh8KrxdqtCpQj3gRYRwDhplOLz0L1Th92xCP23dLrdgV
         HEMuSwyy5lGuRYRq3OLcu/oPf6zFLEoAH07OviEis2OR7hN1L2UhOPXPMNp7bEZmMj1G
         +usUnwrxSgk2sc6MAgHVT8FofNXMwahayAuK1qeKgvTEdkVKafiWvu40QOoYkyOaM6Y/
         /YIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3MSSL4DpI3S5luBJGd7I2XVsr9+lwZ5Fn38DQgSdC/s=;
        fh=0IFhS68hAjOYp2faWoLb1KRPDOc5Jt9MJuoKN64TuSk=;
        b=B7WJo99kzM27LiHN1nub32xcLvV4vsDMRpwZ47iVyz8TKEWwkOcuf5V+T4sTcAsirB
         48iBTrw9nRx9IPflcjRtFGxi3DQJ5BNwu2YQGtQ9diVxsIziqamUXL41m1yHihumpSHG
         XvUgcXLVDg5avZvRU2m/isOsA7VOtTm/u9X+qXjvpmwsDF9xatanZIprqza7r9iMmx6I
         9/UD0RQ7YkyXa/Y/devKjulizxSauIZDQEsRZGwENQ9TuEZPBMaT5zUltAe7yno2hdRN
         ZGPQ2QvhwxQlc+e6t2ZP1qmF2EngzDrVZJRXM1joCffErctb6FOg7jIAfLFcgmjzgAyx
         sDGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787989021; x=1788593821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3MSSL4DpI3S5luBJGd7I2XVsr9+lwZ5Fn38DQgSdC/s=;
        b=ZVWFMtF+S06GRBvuwt2YMjMS/2gH+x5ENJz/rAEm3Qr9FFhoGhCgJXYOmkhDQxZkeg
         5LrGe/zG/euP+tf4emQ+8bMeyPa1SHrRr2DPRx2YuxCVno6vGflnxx7A3rA6g5RoL7eu
         5etlhYe+RkpwNFgP9GUUZwpWaA6p7TwMZc64xfKvTeGI1H72Emaip+sqVL+nJK9p9Ub0
         shBX6QRbVR7lfsmMtKz/7xVqwW8iRbtZGOaFiB/WIlhdY4+dSc3kvxJNV7p697AqJYbX
         ZJPC0cTcn3Zuyonq+k2NFjD3opzzwRbgQd4Oe1/rx+LVSKnjBXH8kn0qPY/NYq8neMOV
         IBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787989021; x=1788593821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MSSL4DpI3S5luBJGd7I2XVsr9+lwZ5Fn38DQgSdC/s=;
        b=FT+y2N1dBMmVYDr8p+dhCM27Surg+nLjzd79DC4kxoPsWLwlygy2uZXrRWaJTX8DIp
         CzdDaLqm1EFRK/IHnCn9roe2HmyN41D6nuAp5pVAjz+SUtBXkzqbk0DMaqhU3QuhPgDD
         8nC8E5QDQeMg9LpP4HcJLEGXmfduKPONXUBKNAubPi0Dz4dhgURtb6G+d/ZCqA5S9mIg
         Rsqum+PH7CPVlvoskn9Ar/OoHUFBvAYl9fKp0kxoTpflhRO6WDO3F6Y2zLOCsqolhgN6
         BP+h+n9qFjxFUnDQX/RJ6ks1DxwB4pwcB3zbeHVYKRWkXAzbumCzL+J3uo3gnQ8JlWyW
         AOWg==
X-Forwarded-Encrypted: i=1; AKwUvBxpe6clin6Yie62VS/7vo1HWLZVdx3sz4uVj+cQ0GdN0wGPv7XdMPUawcpHpcUdxmcFFL/OWJhJHT9q+JLX@vger.kernel.org
X-Gm-Message-State: AFuF++mPxAbcrjcn2hvULnkupYdvKwgvQUatOU/GSMa4k89BM8vbTjVp
	lpTQtsXCobdR7PMjZBa38bE2w1vgYp23RjXlHJely3i5hs2Vh4bMU0RKAI9ttFUtb9Hn6CjlePD
	DaPqg7fGUt/G+mDRAwdoy6nvM+3kDh3YxIhFIDy1e
X-Gm-Gg: AYBFou0DL5wlsVBkCt8AS9ZDtXYjnRgdCnW2JiidP/ZjyY4MaHL3dJBTPcExaIaDNvb
	UqzQ1HJrD4QmgwrGki0VbThRqxiwFWHmD34k4IKff0Tr/Dzz/1a2XFwYugFcdDYABpWAv/wSdkY
	3ckzCRDp0jEPBpLYHteqTiEO/DRmIaQ+s8gGzoilFM0l3/Wxb0Hc4ieVA8nm9xclByw6LPvhEd8
	WAwYRngX3acmlaQ+WufQaDZRJ1ozkqPvLDArMuNf+NLAzJGcNKs1IuznnYKTkm7AeSExI0mZ3BL
	CI4ree6+EYdff+TvWk7ofbK33Lj9Gq/kUy7oHYifcO+txIMi7L/TuckDS9sHC/5WGa1fUyAh8Kr
	BAsEEFGBw5wqC8EK8v5BCeirD4KhJ4dw=
X-Received: by 2002:a17:903:3803:b0:2c8:2808:3ec9 with SMTP id
 d9443c01a7336-2d74df0328amr245182145ad.12.1787989020140; Sat, 29 Aug 2026
 00:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCjUB=g+56ZCrT4MPfWjqBJX_CO=vfp12JLOrh7B53uVWQ@mail.gmail.com>
 <CAKYAXd-+bctZycpVKNkQTifthktnWdfOHsKdsNBzL2droo_yHQ@mail.gmail.com>
In-Reply-To: <CAKYAXd-+bctZycpVKNkQTifthktnWdfOHsKdsNBzL2droo_yHQ@mail.gmail.com>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Sat, 29 Aug 2026 00:36:47 -0700
X-Gm-Features: AcwNN1VBtp80MVnTOITevZF0ucoYfN-z3oSxf1HJNZTS2Qs4XRS_nWl-BWNkbVA
Message-ID: <CA+0ovCjKMHB-TquTScxKkmRascnfe6pfrruT_V_W1TXv5fbg4w@mail.gmail.com>
Subject: Re: [BUG] ksmbd: use-after-free on iface_list from the netdev notifier
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Namjae Jeon <linkinjeon@samba.org>, Steve French <smfrench@gmail.com>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, falemi@asu.edu, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested on 388b607d107c07aaade04c7f22f344cab6bdccd3; patched version no
longer panics.
Thanks!

On Thu, Aug 27, 2026 at 7:39=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> On Fri, Aug 28, 2026 at 8:08=E2=80=AFAM Farhad Alemi <farhad.alemi@berkel=
ey.edu> wrote:
> >
> > Hello Namjae Jeon, Namjae Jeon,
> >
> > While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU'=
s
> > SEFCOM lab, we hit the crash below. Crash reports can be found here:
> >
> >   https://github.com/farhad-alemi/public_bug_reports/tree/main/117-ksmb=
d-unlocked-iface_list-uaf-netdev-event/
> >
> >   refcount_t: addition on 0; use-after-free.
> >   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110
> > lib/refcount.c:25, CPU#1: kworker/u8:3/9983
> >   Modules linked in:
> >   CPU: 1 UID: 0 PID: 9983 Comm: kworker/u8:3 Not tainted 7.1.0-rc5 #1
> > PREEMPT(full)
> >   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > 1.16.3-debian-1.16.3-2 04/01/2014
> >   Workqueue: netns cleanup_net
> >   RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
> >   Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 db 45 27 fd 48 8d 3d 04 03
> > 1a 0b 67 48 0f b9 3a eb 4a e8 c8 45 27 fd 48 8d 3d 01 03 1a 0b <67> 48
> > 0f b9 3a eb 37 e8 b5 45 27 fd 48 8d 3d fe 02 1a 0b 67 48 0f
> >
> > Our reproducer.c is available upon request.
> >
> > Happy to test a patch if that would help.
> Can you test if the attached patch fixes this issue?
>
> Thanks.
