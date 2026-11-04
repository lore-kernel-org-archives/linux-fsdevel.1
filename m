Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793821672;
	b=okjNTilBn49Ga1QStbec+seWLWWnb6KroR9Of0lU/XMtHT5k7Znxlmbf3EBcqVY1uVQS
	 jtz+4fB33GiOnfqLLT3kyAQ58DPHzFhYaGXVKA+l9Hq7WjzlMc2u/ldqwzQJpNE3LFe3a
	 9k/Eh+w20hzUY/+6ds/ekyxpT1++CjF+G4dqC9y6OfpqTwEIo/TPYmzCWrGNvZ1GM+sAx
	 Ny3agllxx0bqtbnn4HgQR+D6FTjya1dDwdVVJhIx9eQlwNXn2ufi9OjiQybyEH0o3UnaD
	 wYLB4nue7uvnXIHNb1oC9Ar/dcd5qaIdM0qUNffNWZVyfRht7VyrTjp/W1BQ/wgLcsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=E8RgS9Fy/AEzzzRdR1tDID8pHQZHUShrwVCmHXZNpOM=;
	b=TW+6SkN+xMbV3LxZbJliN+kidgTeaW9KCgZQFeB4sH9DbabGnCMR1gz7Ij6XXFxSzjbF
	 6PKBBM+2QQKr7/00/6NqgdlFmQYCimQlOE+TZ6Qr7AIhRvsOSkDYrulKRdpIrDBuCekpD
	 QiCkSz+L4f+JifyDvIphTLuBm3X/hM4LsMMXc8Bqg0r/NhyALi0VzRj/QsFkuTU1dpoOy
	 wdc8NGw4m41xirpOwMbL5LFWnqH2iGUlEobCT+oD6oWf65dXCSvLf3eyl67mosRlMeVSO
	 2yy/qHWPTJBzxAYUR4yORoi/Ex+ll0bgB28v9kkzc1EWMtooHzhnySlCaSjAwEq+yzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Pre6/T+K";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5B606AB03
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 19:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD5B606AB03
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pre6/T+K
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9f6a16afcso9345ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 11:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793821672; cv=none;
        d=google.com; s=arc-20260327;
        b=Jdop5JGPkIPuh1KKJxdIdV3fVNp5o5XaGQFo5hIz37MizFsOEF9iWBLIMQnLfbQ2Y3
         Wr//IaXULbw7gROb1Zx5JBlK2/Vjbhftru0GwWY6iDpBkpF570wS8cIJDbBXMuOrTIDt
         gth0M9MDzfhdl0qsSlJ+lE6LkHM9dddT3U7iiWiR4fifkvtUVaDJUUVc31qx9IwXGasS
         w9TB0ubKM8db5mXASPxa6ILghzuvyBcjSOYG3jbciJreTmQ8n/Zma1CVIbL1JdQ5Gip6
         8/51qSHoLUz71csVa9Wg4X6Nba2g9oCWpW5K78HwPUcCwc8Lv2aXTcnpjuRbTmWO5k7I
         vtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E8RgS9Fy/AEzzzRdR1tDID8pHQZHUShrwVCmHXZNpOM=;
        fh=nV/5eH99LlyeFlUhWMWhJB+aiErF2rN7m36f5xgkkbU=;
        b=CmEFqvRtrULgpOnP2pClH92ALDofj4VgHgwoxd4diu3ZoTfks1OPSIaS4uaEZHm0KA
         2yKD1OTe8aNOz9A1WZQprEMK0ipju4GVZ03nRg0xeg8C9mOcONv1Opk0rVo4jxOJhtIb
         HRl784CWlFdv33pIdjVyFVlxJ7oTxLeg6yLJJD9qRSC+Ka75TEnGcv+zIV2SPnCZtKiU
         aMRt7F6WNL92QgaqmccF5ln0r/NsEdjoZbYcAnExsvPHBblSfRujzVIro0temSR7Un8t
         +bHmuVIO9kvAl2iE4S7rzF+KpJAmswJPHE7/oR38Jq1Qv/L5/ayhJO1FX/cowzKfU8Sm
         WKKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793821672; x=1794426472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E8RgS9Fy/AEzzzRdR1tDID8pHQZHUShrwVCmHXZNpOM=;
        b=Pre6/T+KB25HpZOrUgjpGk7BYEiTmgAh2V7MBgC7+kz5pppzdcOtDLW9/HXIsWX7w8
         JGdka7KX2vYErnklggY1QD/7PyLyt/7Ec9VSaJO+xcCBiNu9Vv539qbGYMEZSuxV85OL
         Dj/X/xaXNkRWK4mO75s4bFPODgbSekHYekfO3TCgxx5H+mH+X39Y4mde6JGDE6nZiw8l
         MoCkdlgLpp7ynFSENYC6276qkehDa95pPCMnQVMaKUn2F6BQ09Cl8dg2BqYmiwFft5fT
         +knGNY3hAj6+johQ1ZGTBdHmwXyucQSoMTFGE5wFKLyPobpz2TXj6zanL0E+H1wfyErJ
         q0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821672; x=1794426472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8RgS9Fy/AEzzzRdR1tDID8pHQZHUShrwVCmHXZNpOM=;
        b=j7sONZfRiCEsXsyZnvr2gXAgUedagzP9CyIOF3qpT+5sHOF8eX6CuwnCKWnCYcbqSJ
         CBh9rsu+kb1JegAUuJ6IOr7lrxKB48POwE/S5BJQdpFwxXNH31Jc1lUHpLnyP6HbzGjB
         Kbv+imK5mW7wNBpC/m2YvHWgcSYfRKe0i124YrkIHnU46d6lUtGNr811KQE8uVCP0i+1
         iOVcTbxGOGiqSHRNjK8KzzlCUAJkT984rMyW2pTd9XDzyLsJj2k96yTXtooWsAnZWiOB
         iyJXzyHl7zNzpfITlLH/4M6t9LLSw/QU2FM/rHySKS0fwJQiSHi33jK51yWeH+jxYFHa
         TPYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoXfu9LmFbQnCp46zw6nhhT6PPVQjlrVOoUEsbk7hEQvHJy4qUI5MjIh97S8oJkCiwi5dJg2staTC4O03O@vger.kernel.org
X-Gm-Message-State: APuU4Z8z+lQr5M4vQYKUk4M51LURf0ugboaKLpj1pi6lwQSe14GqMXFU
	G4PmW7yGJ3m6ilkw8ysiU07OVMNv3BZzy1+j6TsDTHwqUz0pcmSjQOtqSdN23uAFor6z+WTiwMg
	x+jCVrToU8N0NWmkJ7nrc8P5CqLRh5AvTMUAebSTB
X-Gm-Gg: AYBFou099LaMfvv7A+U6gt3TR03eet0R1TYI4EirixrAq0dhWgUJOAgkbg3JqF+sr/g
	5rvA/9gIDLmvDQ+YoX13TY/voGyvzVw/NilF6zmCEZPiFYX0vR/K1U7X6WFNaZv83D3Q0l0+7Zv
	IaWizpAEQe+X5BmBe9ACpvU3B2XIG8TucNfClAEv+iwHJEd+8A0kD+hR2/KK5GcDanNCh3pKBrJ
	7JMR1GBa8ZLrdF1K9vLY+SEGsszHjvMpOhZFKE/vGWLclljuXUNVHmiPL5TssAHkMf7ov6P7uhn
	lAQKbC0vWHH2xfFV1qH2tgkJRY7sq8Q7n5hM3a3YiKarEwJpT4BA0s3AFnIDLNoIjqM2fzwxzqd
	VgE7q7Cn61FJRk3y6wTeho3RlKgkAFSFcXzkVwN8UWnfH4X12IvBqulJordRUQmzLJ7098kI2Qk
	XluhUki1jNUOAI9yWhHZ/i3/4=
X-Received: by 2002:a17:903:1a03:b0:2e5:9bdf:6b65 with SMTP id
 d9443c01a7336-2ed25671982mr1025875ad.0.1793821671183; Wed, 04 Nov 2026
 11:47:51 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <auS7gAFy13EOp_Zt@google.com>
In-Reply-To: <auS7gAFy13EOp_Zt@google.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Nov 2026 20:47:14 +0100
X-Gm-Features: AclHuK91TcmyWyDMmafA8MM2TvukK-iXd9ZaYxJjCOqPlgsZDHPV4sGOrjcK_VE
Message-ID: <CAG48ez2e607HNArcX_xA9UTv_u1tvThLwW2kDvnejHcx4A80KA@mail.gmail.com>
Subject: Re: landlock bug: procfs denials because inodes have unstable identity
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 4:45=E2=80=AFPM G=C3=BCnther Noack <gnoack@google.c=
om> wrote:
> The Landlock LSM lets processes define policies which are attached to
> struct inode objects internally.  As a consequence, if filesystems
> forget these inodes and start using new inode objects for the same
> files or directories later on, these policies do not work as intended
> any more.
>
> As it turns out, procfs has that property as well and can lose inode
> identities over time, even though it does not happen immediately.

Right; basically, dentries can be dropped from caches while the
corresponding inodes still exist. In normal filesystems, dentry lookup
rediscovers already-existing inodes, but procfs calls new_inode() for
non-persistent dentries from several places without checking whether
an equivalent inode already exists, which works because procfs doesn't
really tie any state to inodes. new_inode() is called from these
places for non-persistent dentries:

 - proc_pid_make_inode
 - proc_get_inode
 - proc_sys_make_inode

File systems that care about having something like a 1:1 relationship
between an inode and the object it refers to can instead use
mechanisms like path_from_stashed() or iget_locked().

> In my understanding, this is not intended.  Landlock has explicit
> selftests to exercise that Landlock policies work in Procfs.

I think from the procfs perspective, it's currently an intentional
design choice that simplifies procfs implementation.

> For reference, similar issues have been investigated also for hostfs
> [1] and 9p [2]:
>
> [1] https://lore.kernel.org/all/20230309165455.175131-2-mic@digikod.net/
> [2] https://lore.kernel.org/all/cover.1756935780.git.m@maowtm.org/
>
>
> Steps to reproduce
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Process A:
>
> * Enter a Landlock domain where access to /proc/sys/kernel/random
>   (and files below it) is allowed.
> * Repeatedly open and close the boot_id file from that same directory
>
> At the same time, the dentry caches get freed up.
> We can emulate this by writing to /proc/sys/vm/drop_caches from
> another (root) process:
>
> # echo 2 > /proc/sys/vm/drop_caches
>
> Observed result: Process A fails because of a Landlock refusal opening
>   the boot_id file.  When Landlock walks the path for the check, the
>   inodes have now a different identity than before and don't match, so
>   Landlock denies the operation.
>
> Expected result: Dropping the caches should not affect Landlock's
>   behaviour.
>
> At the bottom of this email, I am including the source code for a
> program that does Process A -- you can run this to reproduce, and then
> write into the drop_caches file from another process as root.
>
>
> Solution...?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I don't have a fix for it yet.
>
> I am open to suggestions.  Is this feasible to change in procfs?

A landlock domain is supposed to be usable for a hierarchy of multiple
processes, and for that usecase, if all those processes want a working
/proc/self, landlock currently can't meaningfully restrict procfs
beyond what is done implicitly through ptrace access checks, right? I
think if there is a desire to have fine-grained landlock policies for
procfs, that would first require some design decisions on how procfs
peculiarities like per-process directories should be handled.
I imagine one option would be to add a mechanism that automatically
grants full access to {procfs mount}/$pid of all in-domain pids, and
then consider whether sysctls should have persistent dentries or
something like that?

> =E2=80=94G=C3=BCnther
>
>
>
> Reproducer program, for easier reproduction (don't forget to drop
> caches in parallel):
[...]
