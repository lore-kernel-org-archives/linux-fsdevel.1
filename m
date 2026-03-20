Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D063D4119
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025158; cv=none; b=VT+6ZvKKx+nr0DQ17qPXlIMxC7VAHIw17BOxU4G4iWg6fnhfXDeHMLq4OPj2wExsurGLmCPXU9AGjgRAWABu/YDg0qLH3ljhSoG26SuoAUNHyYvcBxTT4SLuEx+ue91SOrsYDMYK/lUlYMa0u9IqvgGKMMAJQmbBHJ2E2ddhPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025158; c=relaxed/simple;
	bh=cMhLfpRKl6KGKB3rN8CKzcVVi6KnJvjG6BN4ox6Him4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cyr+kiMsVVV0dmqa4FCsnaukT3ZXHW6xbqZYYKDFSHN348etHBkur0QFIdgR9a/3Lh47nT9RJ5Ui78Oq5a7M4NHw1DgJW9OkL/VSA6mzsI9uKYgsqFDwIPbUkRP6O2kCgbJFTNQ7RGS5C4vgeDtuyHEemsFoCxbLzX4WJnj3eCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X1wZ9cY7; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X1wZ9cY7"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d4be94eeacso2289596a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774025155; x=1774629955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN0EHVLsdigfh6ooD//T3G56PBp4ySw3ZWzpugX7Pxs=;
        b=X1wZ9cY7qY5iOQ2benSP4LqVmSNwm4hbBEZEyBqOrUDy9jYUGY9L77Xaa3bRzLlp03
         RF+HiffaCirJ/OvmMrCbGsLghGSkJY3VTHTnXcYEFMoeaeSPdqBJGKjiF9kbD6lsXJIJ
         LI9jc3Zir8Uhlf1rnd2SnK5pXnNXB80aX/Lw96te29ZeRvwKf7f0GP6gCRgCex9UaLQ6
         Ssnd1VjoOS+vRF4g0BVRkNYW6C6wbTZ5NLOyj2uTY5IoGwz4bqugDmm2FKxKSp9m7zcm
         zSDLLE/OYXsEx40XuQZ6tCPJnix+6p242lRvrbwg48HweWx1zOK6512Rr2aO2Agd1ePZ
         3zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025155; x=1774629955;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lN0EHVLsdigfh6ooD//T3G56PBp4ySw3ZWzpugX7Pxs=;
        b=tTFEnSkcPYBVcjzMG1Kjy8NuqyyQc5vf6mt0dVU1b4RdS9tAVYR1fU7wW0fMdm/LQv
         XpHbieRKQdhvY0v4i0vY6spSPopZpisVCAqtbJ4cBUMmIsT6U2NxqLGIhaJ/zBX/8Ylf
         MyoDug9puzvDUeU/3FR0aP7f2MuipxByIfxmDF0QcD3HhBMKC84gibbtt9ouShgFzu4a
         yfCU80RhWuo/KGenUk2jpQvgiV2gGO+/BcqhM+/C/G/l9liOzEjch2HaioPXVoqU49Sy
         7KhDj/82JX7WhRiyYgNdj/az0iq6uDbW6bqOzmJzA6KWZf0PAhnNUeZa6CMnaC6wQHwI
         djZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWdvaGIpLU88Dl0Eh3BCL8i3NMe5VeTTGgaBOFxUQ3+7yCyFyLrvD8tXn1hObN7oyupr5Hx3YZEBhh1qkL@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcXx6q8BeJkcxscmrDnUuPYTKs0oAtveh5p13PTzcTDUqk63X
	P4VhvkP3hDQMvCdCpeMTr5E40mDGSBoczFaOsztUsK6QLn5aSkOebN3gLEhB33VD3iVycBqXB2+
	LDmV6fi8=
X-Gm-Gg: ATEYQzzVb1oM1oVcDkanLAwKGrRZ1P1FQwQ42dsuBp14p9Livc6ivG2HRWVQmH/DCl6
	PtFtzRcjBSW5Z11F3BdvBNiVL/JDHiZa6seEV5MFgjNusHvX0LXMx5atTrmhiApOfp8etfxkR4w
	Gwi/YkJYmTJVeAl+xd2IfJCJLZlTBravkf5CNKvEvSRiZFEdaZsnC3e5wZ2x5pqc9VTgpox4DC0
	p+WoB3Pb1eGIqZdW2Cd5fOjSJTLs9zVV0EG4AUCQ/Muk6E6dZ+zfUexQ7q0sdmrs+JpB91IOYNg
	aBfk32TN+f3h57MXqV4Uo5YWivIxczKFv6OG3RWEDjbr0p0IBpxQZKOp13pCpFOK1/jGL7Iv58Q
	2Ui8LJxTdOuxT0l4OvEQ3q9dneg3/7BywEgg3frVBEOYKk9qfVmbcW0UDhy3Tf7xCplIvfG5RPB
	1fUlyeE8nPLlNykX7oQCVNgrX4AtXFCJC859OibKa74zrGG0L5yxV1UP3h5kXQNGHTmwkcdrHf+
	sllyztg+icrVA==
X-Received: by 2002:a05:6830:838c:b0:7d7:d2f3:d55f with SMTP id 46e09a7af769-7d7eaf67c80mr2672143a34.21.1774025155547;
        Fri, 20 Mar 2026 09:45:55 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eae10537sm2613154a34.22.2026.03.20.09.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:45:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: hch@infradead.org, asml.silence@gmail.com, bernd@bsbernd.com, 
 csander@purestorage.com, krisman@suse.de, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org
In-Reply-To: <20260306003224.3620942-1-joannelkoong@gmail.com>
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
Subject: Re: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
Message-Id: <177402515458.59192.3003058602103165983.b4-ty@kernel.dk>
Date: Fri, 20 Mar 2026 10:45:54 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 05 Mar 2026 16:32:16 -0800, Joanne Koong wrote:
> Currently, io_uring buffer rings require the application to allocate and
> manage the backing buffers. This series introduces buffer rings where the
> kernel allocates and manages the buffers on behalf of the application. From
> the uapi side, this goes through the pbuf ring interface, through the
> IOU_PBUF_RING_KERNEL_MANAGED flag.
> 
> There was a long discussion with Pavel on v1 [1] regarding the design. The
> alternatives were to have the buffers allocated and registered through a
> memory region or through the registered buffers interface and have fuse
> implement ring buffer logic internally outside of io-uring. However, because
> the buffers need to be contiguous for DMA and some high-performance fuse
> servers may need non-fuse io-uring requests to use the buffer ring directly,
> v3 keeps the design.
> 
> [...]

Applied, thanks!

[1/8] io_uring/kbuf: add support for kernel-managed buffer rings
      commit: ff168843d80cd1855b646c5e8be2c6aa5bfb8adb
[2/8] io_uring/kbuf: support kernel-managed buffer rings in buffer selection
      commit: bf4a6eb27f8135f36a5286bd5ba87bf6468c1283
[3/8] io_uring/kbuf: add buffer ring pinning/unpinning
      commit: b6ffe5399bc04abab4da9afb2ba092e6269d7077
[4/8] io_uring/kbuf: return buffer id in buffer selection
      commit: 9aa9e55e8bad1b65c9bcc2892101b06ae00c96d9
[5/8] io_uring/kbuf: add recycling for kernel managed buffer rings
      commit: de48bc0efc58d1ebf7e35c36dde6eb0e6b246b8c
[6/8] io_uring/kbuf: add io_uring_is_kmbuf_ring()
      commit: 08b57b67602a98abf4b454a363263cba9fcfc91f
[7/8] io_uring/kbuf: export io_ring_buffer_select()
      commit: 4706d1f235ff94f19b5c818bc0a3abd735903695
[8/8] io_uring/cmd: set selected buffer index in __io_uring_cmd_done()
      commit: 3515a2aedcdf459fc851df40a3712fc4a9a060f7

Best regards,
-- 
Jens Axboe



