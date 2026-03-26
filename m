Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF63BED28
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568586; cv=pass; b=DXuzflvc26TR4sa0CWFwSf6eX91PPpvfuNnYtsL+cV9aFeKHOKRIPjB3PJB7EcmYi2JicC0aPTvLy/1cHDP/qNSzUTLblXEiBRA/LWtPEiFj76jMnbJgyWqipgIxFu/0qWAC3cGLXC+QqFoFISPfBdMlR/3SxzhV8e1e6qc1iLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568586; c=relaxed/simple;
	bh=te2zT25Ks5cVGGQRJFsQTdoq7+P8sIjDPy3cnuoauho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTrMKEyi+C5ozXfSaioQW7kc7JpUvx91KfcRnBmYu8zBCbhI5Y16Vvsuh41KEzCWicFaUaljUJYE4Pq+VGI/sVQQOC/hXbx4u8S2JpCRUyxecZ3bdGumqSm6X15o9tpuXKBXGAmX3F+9gF9dE2CnwbYKmrmmBDyK7tkI7XevE14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWSjIKGz; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWSjIKGz"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4152698e745so576268fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774568584; cv=none;
        d=google.com; s=arc-20240605;
        b=ikO1Wi+ZGorAryVN1yjlB7baucimOuMhz+fGl6r3lWwv2ILkN7TwvaYZtBM6ujxug1
         MSwdjSuWscnm04isDKLD8JAdBriYQHm/KrF1TaPaEXCEL4flQoIhNb0lnPIYbjGQVNV6
         8bgG9Q/SGwnioXkhAagUs7PcbJ2Qg5QntaQbImWQxAdzL/Pj3OHNQXliJGvENCuk9a17
         l7sZzsImbm8YZIVdE8b8aouzjrJ1bxPQ7RaWM3TYvVTaQmfaxb/Z7j3LekK9blvoSxOq
         WyaEIjamcTsYU+3t32VX1uohuO2FUICnxxfY22MbnEc7PnpnCHfSJbFyV4BfXa5nQ1Ay
         hTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSIfNjZqpVj/kLdEFTF+RYLofN7r0K6iJ3P130bnlx4=;
        fh=EgnYG4O0UzQbKmlqHczYsFs+HJ8aGlHoBNKG8f+3zHo=;
        b=OfKC2RM8zt5xPAOepCfqfuoYP//7Jg78wyUE+triKfN+yEpAZoRKCy5j+K1LNyz80Z
         27LGLag+PXPyI0XDhJMK9c5C2syq6x8MruNwvF56LBPQolsb18Eg+3GDZxSEaPZ8LaHK
         JEin8xcJ5uW6Qg9EP4Mv7rNPMTRH4tbf1GZgVZgWLZAk2pdSee++d1OK2ttdBL5YFrAc
         MiVFtTfOpDxHDrO14OhcvadaNl8AX0cRNzYEYRLqMlqkoxJVQdIFro2IpNfCX2tR9Q4O
         wqjArOuRMSNQjT5qEQv3Idv2nRoshJufDPWwHQyJNdmrEVoQEfk4sKr5EZ+lBJ5y/D6W
         YQVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568584; x=1775173384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSIfNjZqpVj/kLdEFTF+RYLofN7r0K6iJ3P130bnlx4=;
        b=mWSjIKGzFiCSbkxf8rWm/BhkuVKi5x2mXuypXZ4g1n99NqcgZMgYdB6H5+n8ysDaxJ
         U1VlLKerOdc8Qrr+ShrRYgGb5nu3Q8XYKdFgVr01J+JUWXm6Vz9uQ2D/kRQoORYtEa4M
         3lcFBDEga88crEo2GDz1EkNKSYF4S62yvQg91RBAhBhuNZtgwaYSpvYn3fkUxmgSbSCf
         d6GnInIP8wkkPXfS+Ev84lieQkg/D627wpaxZOtqvKVR+Utf1Q9OTVopTaZR32R7ZFK9
         OOIBR4benxqkmQwppSA8DmQo0kOd5vlDOSXtXT3F/5O2L61u1d2+uDiZVbH4bf4UUmbM
         Ik/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568584; x=1775173384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSIfNjZqpVj/kLdEFTF+RYLofN7r0K6iJ3P130bnlx4=;
        b=OQLRDealb1Zrc7uirGPxddLSR44i6Bbmma3FXEpR6pO7VWbhqJEwyXofQSKWsg40vl
         2ofs0epNfMPGkIMtYD/z1AxNbmxtAACNg4UyjMhowFQWfUd5o2yEUoYud7vYXv8qx5VM
         CUELVmTw4XQUW6EzCZZQHjpfy0+v/sHKnqzSi4e2gLBmU+W6yuPfpNG2bowNMKp6sdex
         He13jt+KpW6noUO+3aGZiFKvsHTmMduul2WvvWbINGRqU0ko++Xd6/M8a3LkRhGj5+Wi
         4TUmdg61ClSvrChv/3MUtZn8JddAPgrJLy4hUsydCw3OKbK82J/oMUz6wB0+4MtDoeVT
         4RQA==
X-Forwarded-Encrypted: i=1; AJvYcCVRlPgEP4iS2I4VG2U/2Iqa/70LGKOo6ZiZdbmv+qLS++cqDR6hdyV9kbVTLkLPyLqfQNXSuQ8qCVDMDVSb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1MNKAKo7jIirUZ7PyM1fMpiuM7/UHjdC6s2sAzxjUO/uKyf7n
	/CavZpHCdtp1QOkiCAlhbquZ+9wiI8BCUojXactroTCVGuwSFIoO8t3vDlW70xAONrGdgMYkmKU
	6MSEmmqDgBeXxIUH0p/I49QxiO5aXCls=
X-Gm-Gg: ATEYQzymhs4hTKxjZ+P4f0ZgcHAZ6AZOxizBCo/Bf/mL/7WsBMPXPSaytXmohxY5224
	yxDj5O9rPtpiFLKL8iHEhR4xFl9Dj6pdvTrHFRmYY0DCRJ4BcQZ3q3pNQi0PVMX3BFF8/b3jnlj
	A8CcxMfg43yLxs22MoMob9DrwOEYOwYoC0h/zgQc6j7YgT1Aa9Ry115tIKvdaWxydaXP/OCOgHN
	cPXiGVuA5cXShSI3qZANKt8DwH678ZPjxpK/PXg2jlaQxtE2Vj73ZnWh9x1b0I+5tpUWB/aj55Y
	kB/deIjPrFPsgllVnYguI2cO5o1YZst57yHc/XdkR+n5vNynmkfGJitpTNdVI5Zlengo
X-Received: by 2002:a05:6820:4d0a:b0:661:1188:4b99 with SMTP id
 006d021491bc7-67e185f1ec8mr255826eaf.3.1774568584236; Thu, 26 Mar 2026
 16:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326232130.1891210-1-turyshen@gmail.com> <CAGudoHEHua4cA2-jZ0Yf54LQtuG_7=We-EMcW-yriNQ5JZzM5A@mail.gmail.com>
 <CAHLHtjzi5uKrNDyjL60nZ6TUZnae5gDaEHL8dwbMECBT1L6tdg@mail.gmail.com>
In-Reply-To: <CAHLHtjzi5uKrNDyjL60nZ6TUZnae5gDaEHL8dwbMECBT1L6tdg@mail.gmail.com>
From: Xiang Shen <turyshen@gmail.com>
Date: Fri, 27 Mar 2026 10:42:53 +1100
X-Gm-Features: AQROBzBxfKPTlZW-oKH8yCwx7Z5uui51ndN6KoM4FAQWEm_yzWqtuMga1zg0_-4
Message-ID: <CAHLHtjyOim1QrH_xdaePDPqG2XdAeme7=1ZT8_gfr7phBnjfdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: fix deadlock in insert_inode_locked() waiting for
 inode eviction
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Withdrawing this in favor of Jan Kara's ext4-side fix.

Sorry for the noise.


On Fri, 27 Mar 2026 at 10:40, Xiang Shen <turyshen@gmail.com> wrote:
>
> Withdrawing this in favor of Jan Kara's ext4-side fix.
>
> Sorry for the noise.
>
> On Fri, 27 Mar 2026 at 10:29, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> On Fri, Mar 27, 2026 at 12:21=E2=80=AFAM Xiang Shen <turyshen@gmail.com>=
 wrote:
>> >
>> > Commit 88ec797c4680 ("fs: make insert_inode_locked() wait for inode
>> > destruction") changed insert_inode_locked() to sleep via
>> > __wait_on_freeing_inode() when it encounters an inode being freed.  Th=
is
>> > introduces a deadlock when the caller already holds resources that the
>> > eviction path needs.
>> >
>> > For example, ext4_new_inode() holds an active jbd2 journal handle when
>> > it calls insert_inode_locked().  If a stale inode with the same ino is
>> > being freed, the function now sleeps waiting for eviction to complete.
>> > However, ext4_evict_inode() needs to start a new journal transaction v=
ia
>> > ext4_journal_start(), which may block in add_transaction_credits()
>> > waiting for the current transaction to commit.  That transaction canno=
t
>> > commit because the caller's handle (in ext4_new_inode) is still active=
,
>> > resulting in a deadlock:
>> >
>> >   Thread A (ext4_new_inode)         Thread B (evicting old inode)
>> >   -------------------------         ----------------------------
>> >   jbd2_journal_start() -> handle
>> >   insert_inode_locked()
>> >     finds old inode I_FREEING
>> >     __wait_on_freeing_inode()
>> >       schedule() [waits for B]      ext4_evict_inode()
>> >                                       ext4_journal_start()
>> >                                         add_transaction_credits()
>> >                                           [waits for T to commit]
>> >                                           [T blocked by A's handle]
>> >
>> > Fix this by replacing the blocking __wait_on_freeing_inode() call with=
 a
>> > non-blocking drop-and-retry loop.  When a freeing inode is encountered=
,
>> > drop both i_lock and inode_hash_lock, yield the CPU with cond_resched(=
),
>> > and restart the outer while(1) loop via continue.
>> >
>>
>> Please see the ext4 fix:
>> https://lore.kernel.org/linux-ext4/20260320090428.24899-2-jack@suse.cz/
