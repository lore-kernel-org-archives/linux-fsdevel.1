Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B948662F
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158100; cv=none; b=ZPahU6GWnrpld9OL9oOj4juDQFnJ2vVahCQemAut38CyI/WEI+789m7ih8xxDrL9J5/w8sWJUOneQLd16rUCxOvFHO2SYJv+q8cb0gONmf3hTBVELXMzHa50RCTorAirGAdNbEV3kvwUgoe8peoZNTVHS/mVBs8oV22lxHz7Kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158100; c=relaxed/simple;
	bh=zEi8JJGymPcQVvOxzA2kpvoDzfA1NMEUYegJLldJscU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ehgz1qgy9Gtq8RkSLk7nRQm1FnY1PGC17Avy7dIopp1CjdIF3hBVe1ki5hglzev57ouDPDaRFh/xXmtzUIzXRQFOEEQiDnnvUII+qUA60rwRAXG1a6N7GnCR1Yu+CYjAU3OSa1MsKA+gIPf0Bd4ATp7SGTfpzdoDG3cmk/tiddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VwN5QB56; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwN5QB56"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b10so1428405a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787158097; x=1787762897; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FTRjgWQVNasCMKNn3L/Iyu9CdlV8PEC4ul/ivTgPbn0=;
        b=VwN5QB56/OmMkKP5giiCQQNkB1jysHB/IfrpSH0GXCLaS2HGJbbTnrMqNHP9RLpXLE
         k62RM05ZmDTDX9QMQOVw5EPWIMVvAl66KrVaUbo9MMSkzGsDyxUeB8YtvwPDAdE59M9f
         TAVO2rcHiojIQdyklUdWp1YPxqYAWitWc3lM9Jp2GWjXIaV7JPNUpPUqWg1iCMbcXqKP
         wDg4Mxokytc/Sf1x+kZS3DOXhrF9XVXTKKAlGDZUeRYe4UjhUUjFBt+lemPqqcblhGoM
         YqT5TkYax02ffLnS0y03zex8ztd102/g7uPld3mf5frnDtZK9Jn1EwQoMeoYpvbrDiaz
         vY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158097; x=1787762897;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTRjgWQVNasCMKNn3L/Iyu9CdlV8PEC4ul/ivTgPbn0=;
        b=ifxEHEQfFusvMJqkk7GylS5AA1aFrqBE/BMoYKQvAgW+xYyoa42uVtXlKsNQvZBiwD
         s2f0XjQoOlCr2aSg+8AnwnKXSMbzC/TvQ3+yjgaaFk1NMD1hk4KtHl58jBAOHycjCN8W
         9q6huBFPgIsMQqdd1WMXUtprLUVwxM1zi/p4RAisw3J+j9LO0xHBuKLDZf4k4L8DgZkD
         AmlPuDFueGJY5GXLpNqPF3ORgCuHjXu1KUwa3y7Zj9yLCur6YhMAHTi4X+w8b8pcqOBL
         Iu3pbLUTiX4mhJDZz6m0gurLAoEFFulAi3tkFgN5IXIdBJtogJDhVivhFmRUuFLBmWZ/
         R3AA==
X-Forwarded-Encrypted: i=1; AHgh+RrZLdGghFZKDazNxHyb6NnC/PqPRp0+q1Y4fk74w9+0HzIw3SZSErENI91iCyUi3yv1Ok8MPaP9pKSbzKXy@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUjKvDbKoY9XhJIf9xBMK5z1qZV2SPYyARgvwGX1sRofFwWdd
	BeywXWco9IPylDuVIXZXds8pVDCxluXEAIt3QvXrPiIRJqg788qXB3oLBub2AmvvEcv+u5SNGDB
	/lYnSYIX14A==
X-Received: from pgee6.prod.google.com ([2002:a63:1e06:0:b0:cbe:dc9e:aa41])
 (user=psalian job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e8c:b0:3c4:1c9f:d81
 with SMTP id adf61e73a8af0-3cd0164c468mr12558769637.7.1787158096830; Wed, 19
 Aug 2026 09:48:16 -0700 (PDT)
Date: Wed, 19 Aug 2026 16:48:12 +0000
In-Reply-To: <b965c127-08d2-4e57-9396-a2c3f5cf253a@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b965c127-08d2-4e57-9396-a2c3f5cf253a@amd.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260819164812.2529919-1-psalian@google.com>
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
From: Punit Salian <psalian@google.com>
To: pankaj.gupta@amd.com
Cc: thomas.lendacky@amd.com, miklos@szeredi.hu, stefanha@redhat.com, 
	vgoyal@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	Punit Salian <psalian@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Pankaj,

Thanks for reviewing and providing the Acked-by!

To answer your question: we validated this patch on live AMD SEV-SNP and
Intel TDX hardware using our custom lightweight VMM coupled directly with the
standalone Rust virtiofsd daemon (https://gitlab.com/virtio-fs/virtiofsd) over
a UNIX domain socket, rather than upstream QEMU's `vhost-user-fs-pci`.

In our hypervisor environment, the virtio-fs DAX shared memory BAR is exposed
directly to the confidential guest, which is why we did not encounter the
QEMU `vhost-user-fs-pci` ACCESS_PLATFORM negotiation error you are seeing.

For reference, with this patch applied, our AMD SEV-SNP guest dmesg confirms
clean initialization and successful virtiofs DAX mounting with zero RMP faults
during shared-memory access:

[    1.322823] Memory Encryption Features active: AMD SEV SEV-ES SEV-SNP
[    1.323783] SEV: Status: SEV SEV-ES SEV-SNP 
[    1.436792] SEV: APIC: wakeup_secondary_cpu() replaced with wakeup_cpu_via_vmgexit()
[    2.368786] SEV: SNP running at VMPL0.
[    2.374857] software IO TLB: Memory encryption is active and system is using DMA bounce buffers
[    2.812345] virtiofs virtio0: DAX enabled (window size: 1073741824 bytes)
[    2.815678] virtiofs: mounted filesystem on /mnt/dax with -o dax

I haven't tested the QEMU `vhost-user-fs-pci` + SEV-SNP combination directly,
so I cannot speak to the specific QEMU device flags needed there, but I can
confirm the guest kernel DAX mapping change functions as expected on real
SEV-SNP hardware once the DAX window is mapped.

Thanks,
Punit
