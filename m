Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795744682;
	b=KzNjcbmVX5QFM3a+n7OW7WBmx/rWl1kTX9FbRpYwdVeGTZnJzPAQw4kOSXdTkjmxN+gS
	 Bc+VK369+PvsHBM8wb+fU0KCX55vo1fPKKxBgH6eRxUc2tUnxgl1GKFNlDPmSHsZxRscA
	 qluhCDdBhOgeduvNZdTmwVe2Ynyr42HDnDRfHGgy0PvR4ynSB6KeDF/o/hREYTgqnHNg5
	 Hm6h6kPq2QteADyW2Y/cwHlhsqjzPzSOxW5N1splP/ad5+iP21azVOn/WwKxaIc7WGEHN
	 XrYT6CCcX9jskrGGRBzErm+xRrPSTFIdI4ULFTc5EhTALkIpYOb0qAeG3IzLojWhAbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References;
	bh=ehVaAjvNIfxC+oqsI5UfGcgMz+JKUDo/Bvw/5n/ejys=;
	b=0ldTONdq2bh130ArSzSpNZmlnjWv/URyjya2FPpHpx0yiWJpE2WSUyUlhJOHMunwx2AC
	 NE7S11gyyVNTN9upKIVBL+/LIfsHA8N1O2vWyxBAX2js40Dk+xhCrZ4LASE8Vec7rH4Dv
	 0TOHtnNo9PKB9K3ONUWvOVEAJIyN/SpQ5sfYgYkoecGszDwTbPmWGwelG48Z8AzEnuRpb
	 uLQwXS8JC+fbhr2o5xiLnuRM85+AdkvW1n+oUfErp1JVrXlCbxh9eTBbe6y++PMVQnE9A
	 EUcZyI8xO719QUPBYV/Rh5979WKmLVO28yhoX4SqGh/mOihBuOneo06UAb1olLZ605A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pnvri9dK;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3B606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 01:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3E3B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pnvri9dK
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-921318b2eb8so92981886d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 17:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795744681; x=1796349481; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ehVaAjvNIfxC+oqsI5UfGcgMz+JKUDo/Bvw/5n/ejys=;
        b=Pnvri9dKqQyBU7Va2yfxz9j0DUuvH8l9Ao9oag4ViF8eqg0f0L7GKm0DYyVkLwVa1n
         GoAXwzuKghvdOKCA+dp6x7Hnp0mmQN4Wci/RA4/jE0sO6EkLlmY76GiaLL7Y0trsQFfm
         f2TGGKgB7eo0fFLe/OSLBthacaDwJXySENC2I5souOh94SC+U7HP32UEtA/fTEx9AEn3
         pwL5HE+6ZmV3dLKkyFT9bIH9L4q8KnOsSVA1T7IiNx6N0AsDZ2VzdiAwaPUwOwobHBJx
         0gvcsye9VqAUaX+CU290cazctiSB0J5yub8mHKNk61TbjvE71WOe/+jjlu64RLvdfE5r
         6opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795744681; x=1796349481;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehVaAjvNIfxC+oqsI5UfGcgMz+JKUDo/Bvw/5n/ejys=;
        b=Xho+ZyLbJiFZUdwDAfVVw43ifdTwf6ornm/F6pLZnWroUDqnj7u/M9X/ytBXGFQ6J6
         DTR41JvExDynkA4/pQnLrZwCh/Jk1jRqjUDkBSCsVbLu7cwVJfa9Ec2gDatqxhqB010Q
         mltI3hpWwUt2AKWfkrbYSyNmOixWTPlYgB3f27pg70ZW5mlTgJbvtQKgttrI4YInXSbo
         ecBV9DcVaK/H8n24RpkVcmeq+1u4WvCLb+dzzpt4ucH/pbKuXlbPNbp6HGzjCoN530Rh
         KVbokvYajIEb+Ee3hcM/7pKwCyWpVKECdiEY7FNigmV77z9l0hS2h7lVZxaTB6QyeMUv
         kN8A==
X-Forwarded-Encrypted: i=1; AL+hErHpzJ+V3XybKjQj3AoBO9GsfyNZGUuUnR3VZwTnugZwfRCIAbHf3+87jVXmucWjMKKIjSv3Lt0JeSNr5s+s@vger.kernel.org
X-Gm-Message-State: APuU4Z/kb8MoB4N4x4FWnd1ljf/6XRdpHNd/j/jGjkZ0Bo8BVxGuaBOB
	HV101ATJkMtQ5TtlGNQ4Yn9Sy6d0oBWQddABhX8FL839vhruTaDrxB7o
X-Gm-Gg: AZFdTZeruXVmMBcR5sm54W5kfNu/++TcFvAs13U81T1qH9s+qpz8Y7tvgKIsvSbIVCj
	H9HosdKa0Gcf8L1E0zb/jCn0Oc51K+TMXNtfWZWpsiBdCoCoyPv/423Yj1xfuZ/lhJD3/y4Sj5C
	956+Yp9Z8dAejkvabpdGut6d7sywKQHsSwOEFIP/3tXASy82YUNAMUsTsaqAxJE88NKOOC3o7va
	AAK5qI892mNgwOORhn5umQwKolpmzR35Qh+M0fFp9awUfGmDeZCziXnWqBZjdpIcDEuEALARWs7
	WiY3kqV9w33PBQioqb7WM7udGXpndKKkC5goaSKzoZMpAeYKmj7csOwMYsF0i552FlmlWMhs4xt
	oUqf39QEFUxpXa6vl0vG3IkyGy7SN3BE11JpicZTCErGBcdxuzGuoskL6ItW6g+fBc+HmVvOJ5A
	pVqjd1EZYCiYR0M7WSUKXPgNxGNa2tMAnapRIg94b1hXZ/4BMPSEujifeftwQX47rtUwLx6PNsZ
	AKGzfVSdvUMZujUsQEZMC6zTTv2ogjS5A4EO5pA7jtFwuyxIQdg63QKxkap2zN3TnU/T6TuS0pH
	6rwG0R/4I6wxSiiWSAYlJ7Iel3MrOU4qnxD4Fq12wG8dP7BFxgfIC72IwJBvrVOif8ZUaexaDxv
	LGQb7IKgZ29JUTV4aNhU4EPJTGg==
X-Received: by 2002:a05:6214:4197:b0:91e:9b17:2be9 with SMTP id 6a1803df08f44-92134a8c2cemr403235366d6.36.1795744680871;
        Thu, 26 Nov 2026 17:58:00 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d0e35sm203478486d6.20.2026.11.26.17.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:58:00 -0800 (PST)
Date: Fri, 27 Nov 2026 04:57:58 +0300
Message-ID: <dfcd154c01206a9fd23e0a26f3aef3da.ndokutovich@gmail.com>
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/15] super: fixes for freezing, reconfiguration and
 error reporting
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

Tested-by: Nikolai Dokutovich <ndokutovich@gmail.com>

Tested vfs-7.5.super at 5c8e69ad504d (7.4.0-rc1 based, so including
78f687e0e0dd for the -EALREADY follow-up) on x86_64 in QEMU/KVM with a
KASAN kernel, CONFIG_FAIL_MAKE_REQUEST=y and debugfs mounted:

  bdev_freeze_test  1/1 pass  (sync_error_does_not_strand_freeze)
  bdev_thaw_test    1/1 pass  (fithaw_during_dm_suspend)
  shared_bdev_test  6/6 pass
  quotactl_test     4/4 pass

No KASAN reports.

I also checked the userspace contract that the -EALREADY change touches:
FITHAW on an unfrozen ext4 filesystem, and a second FITHAW after a real
freeze/thaw, both still return EINVAL, so fsfreeze and qemu-guest-agent
see no change.  Happy to turn that check into a selftest case if you
want it covered.

Thanks,
Nikolai Dokutovich
