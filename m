Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605195;
	b=YH2/NmJMictW98NhFGLSOS9NiyWF2H/wsh28cAxUu4tX/WTsYBQVtA6m8uuvPVMKu+vX
	 TYM2EifGv1wORlnCiXN6D4M4rSZ0LczpvwTCz0oLcyyUkD97M8f84qBUqmXmjKllN23OV
	 9/X3EZ0OghF/yBVTsbIFQrsTMooxZecfW3puSf5VGLfOI7wE6nnMWqhEg6Ja9caNV7Dfq
	 0pB+jArkLS9G6on7KrLFjhkoHKMbbO26MUe+gQJOo/wEurF8SIyw5Ia2Cv+kEU0uKxius
	 43cXZRCRc/SYIcN978Abu51VFhdU+sAlisOOJxxLWQwXnv+7KduG6ZtPmmqCdvHkNdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=EKHQEVKe3P8J8ao8BGzCfnwn7QspA2SFir6fQkjj/Rw=;
	b=nxf9cegfiB4KEvXbtERpXSIr+3q2pAUNJVWnIkS8BGMBixYO9OHaARpR2TYtipCDkhMa
	 rknKM5nhwPczHjyuLwj3oHc56L2axfZMK1MeEnscobTIFzXBzuPADVnJ7YhVxldp56lEU
	 Ye2B3wncRt08DDVhMjCRNBdZWH/1pr8INV/Q23kk4qsAOSCaWW2H6Csc0LsErLyvzzjHx
	 xLnFVIBzE5y4NsSq9uNAd+ciB1I4hBKsrRW7Ft2c/V//PM8tcUNbTXXG+u4EjcHF61Kvt
	 fSOSDOWiXGzuhTAOrsbkzlfSut9tE/1zeQ6G8WjB5Lc6NY5oog47wGLpvKAP/3b+58A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xy9bMYJv;
	arc=none smtp.remote-ip=74.125.230.200
Received: from mail-qk2-f8.google.com (mail-qk2-f8.google.com [74.125.230.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D2606A322
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 17:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC8D2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xy9bMYJv
Received: by mail-qk2-f8.google.com with SMTP id af79cd13be357-9369a6afaf8so53450785a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605194; x=1793209994; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKHQEVKe3P8J8ao8BGzCfnwn7QspA2SFir6fQkjj/Rw=;
        b=Xy9bMYJv3tkYhDXnapLP6C0yHm2bzQ/rafwOM4Ilu01F65xSFOYh1wFyLwCwBjrT4t
         eDu3BdrIiLJ/qxbERDrPAcbaSTeoA1FdVGyATVWd9xmHI4wkFg+AJDXYiyWhZ2cPaJ+0
         xrXLoQ5Ri7zSUX3YnAWa+bKaJG//8f/f8niC5iQDny3H3Hd3eStHOXj/yUUcNEF6A3lS
         zWuxaPHajm+xUTUSBz7b8JTEfNL2+kS3BB15EkFSgjhqN6OMUH6EF9bh7bBShV+ahGW7
         hngoD7WHZ7YFr6IlRsPIM02XQ3oenYbeLj8qY5kBD02WbEX8g2XcyHE5EyzsGXbPmKEh
         tsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605194; x=1793209994;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EKHQEVKe3P8J8ao8BGzCfnwn7QspA2SFir6fQkjj/Rw=;
        b=xWCqWyYI51atBoX7P6zaAtPJE0rLOzw5J1NfXcu5zIMzNC0GtxZHE5cu4dywRCQlVf
         e0LHtdhPq5Kdu1ae5zsjRf0edMZpiTGOOtOl81xaD4Pvmn60tEFRXN3ffQBe6Ctwmy1M
         53SVPNr9CrwwSmOARoj/aNJa80uAnOHp/AO1hnzgJ88No0mHMmvHKye8cAfWzdaXjuWA
         9wJ6+IeEj2SbqmRKs5HlXprdgsHt/N4+eO3SxzuyaWeW3LZtghM+A+px9k6CvVlHw2W7
         nRYXZHvYnZk0XR2BKPaSTfrZ5IOTCdrUYrlPQZ423K9fc2k69Op/smHw9aNqdoq/OqRq
         +knA==
X-Gm-Message-State: AFq9FYIoQLwSZ3b4Ei1YdkeqwWq9fJSmQ+DnVZu4pQdJSczWcVwNOG2D
	mY0RR4F67CxtEp3i5vSJz881N3hw8oBOLqfzPIqWqM3vQo0pV78A2aQ1w87MHfxf
X-Gm-Gg: AYBFou2ADg3drqnPs4BvmEW+jTUvbUg+xA0Xi5F8Te3rNZtYR3Ks0pKaiuzhO24K6Q8
	Hq1pKGfOTvs4b0PfDax7ZgPWO7vrFXL5wXD8z5oNMyn0b5Z6oxa7+hoCBszuymVVjnPOLTXof50
	FbF7gCGNPVTOhh+Dvwp3/6XTRD2ENeki09tLOKwW+GC9FktW3LLt0v16b7JlbTzIFJHIxOphVTQ
	/8dlHtNlJRK9W1aejCleJgcWDd6x9x9MTqStptPSZaqu6CbVKCEsZSq5IKjIi52thl06D0SO0FT
	8mUEL4G40lemMcgxyyBJeVEwFzsdyA0ssaPMvxBY+dp1BFSwUUYfYpodR5eBmMZJW1KcJS2U3af
	SbpWFB5p6oECZJZVkmKKhxjzG95YDTBrCTjZ13lBh4ofOu8orWT17MfrXtYZGDIBJ/t1SfhypfL
	7BiML9afEGzsJ1RxZTbEM8K7x7UWEpYkmPMSItXlyq+hBtaimFntjO1kLCr9pM62nQaV3m6v9/f
	Qv2LD+jVAeDppd4weIYXYMSxf7la76cuVc2XWt7TtnAEc9M2AJGYlRAFseb23iJPXpyjFm3HD/r
	sLyiO4fWLQ==
X-Received: by 2002:a05:620a:2987:b0:93e:95ce:53c7 with SMTP id af79cd13be357-93f57f05babmr488590585a.4.1792605193584;
        Wed, 21 Oct 2026 10:53:13 -0700 (PDT)
Received: from Fujo.localdomain ([142.188.41.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d9af50sm305675385a.8.2026.10.21.10.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:53:13 -0700 (PDT)
From: fujo <hooyan2024@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, shaos <shawnq1@163.com>
Subject: [PATCH 0/2] fs: two mount API fixes
Date: Wed, 21 Oct 2026 13:51:51 -0400
Message-ID: <179260511193.411.2849255769062027805@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Two mount API edge cases reported by shaos, both reproduced on
7.3.0-rc7 (58161ead2) with a small syscall probe run as /init under
QEMU with KASAN:

 - statmount(2) with STATMOUNT_MNT_UIDMAP on a mount that is not
   idmapped and a short buffer copied the reserved empty string at
   offset 512, one byte past the declared bufsize, and returned
   success.

 - listmount(2) and listns(2) with a U64_MAX cursor wrapped around to
   zero and restarted the enumeration at the first entry.

Probe output before:

  uidmap buf=100  ret=0   size=101 byte512=0
  lm cursor=MAX   ret=1   id0=2147483651
  ln cursor=MAX   ret=8   id0=1 id1=2

after:

  uidmap buf=100  ret=-75 (EOVERFLOW) byte512=170
  lm cursor=MAX   ret=-22 (EINVAL)
  ln cursor=MAX   ret=-22 (EINVAL)

The in-tree statmount_test (17/17), statmount_test_ns (2/2) and
listmount_test (2/2) pass with both patches applied.

Thanks,
fujo
