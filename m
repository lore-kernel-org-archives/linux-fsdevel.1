Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206613E63B3
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168463; cv=none; b=u2+pJHWYrPmIUF7dbpTK4tfYKme336BX798/Zskwp78Nzf3zSzl8a3skXaduChzIae+vrwACoSI0HPXiK6LwwF3mEfUXDXMN1rujJi1PRtwpoTUYrp5suIdR0GYq5RBH+J1BVk2O61ka6S2tJRr5M5TK5goCc68Tp032kRFl7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168463; c=relaxed/simple;
	bh=U2wZqUTCK83/IxPTnPQYhXtAolBiCnHNAgHzDmSEW7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j8RIUvrnDuWUyqG6r4FkrDwSlq0Z/10HXvxgqMwHbmzUl7vuyLw6VBVgvkJK5CI5fcrBUo09mNyg50z90ts4MGodfNLnZVLKG+xKSNGrU1IwdtEWRhdzp7N97rzUB3B6NJugvq/+aq92BmuEu/0b2n8qlxyAWmzNg+bAzy9jP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so6753275e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 05:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168460; x=1776773260;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqwumVkV7OjtVVY6WSleaCUArhIFQ0xmlwKBOzFdjDs=;
        b=ndL4VpQ2HsI2j/Kuf6GLVSh3vvKOyZIeoPBlAEtrfdtxVI9EhdIfS/Cg9QEw4aFkDg
         VKzJaxijDds/zDrpVgoc2nheU8XzUSA3hzAqp338Uef72MU8OLJwJgjUy5O5kh3ppSc8
         hvUt8WcrxEjBfPaZxo0bgEmM5sZtUbf5Rw7h2Oc4eU9ufdbc8r0YkC7II5OcriF+CnkT
         K148y96xigNqLX48rvX+t+6O1J8q6/yEY9QmE4iwVaAnA5FIk4Qjub2IeaboqJZDr1BW
         F2AsFC6Ql5nuUCBd4JmzgwCrBtEe0Zc3yWdJo0TBUsNzrWhM48R0kj6OpUUlhyh5CF/z
         IzNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8H5oHMQeUJB0D+XHEiws7FNeGJvMP0EGE1Zam1w/3nrKv7lotVeIyz1sH+bWrcwX1b689hf5j9UBHfkTlm@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMnhKrBqAz23mUisj2u0EKLbbZfFqTr0tKeOLdiArPZSCYW2V
	2/qvHbua68XJr5RRVAXEwOI/Jw43A3mHydza0xJrQ2zUMnKrnh+racl0
X-Gm-Gg: AeBDieuWkrlA4gzTjDiGlfI6DrjZWG0xly+ELBsPQ9xZVHkJqVxr9yRcG/WPpnsQ/Sf
	TIZaObl+yrk1j4NBnEjAmCSiuccAj07efF+f/F/emwx3+q6mazhAsebjlkyukVc6thsEus2cR+9
	c8EAX7dNtbM4YzbN18CwcTE6Fn3tpZqMIvy8QtCO1a3r/WGCLPVnFxcvbVnZeS8Ze+1UkostUrO
	WbgH2qF6hiC6KqhqNh75bj0MWqWhfgYMO62WxAhb5O086YN8tSPVPNXeuQAwH3Y6h6Zvr+6/JfZ
	ZwYp7cKWF/FR1IJTR7kCCmlHQRILj6BSjhwqgU+356RietNZafZFbNEgAhE3bfLzLxS5lwyn8rT
	D43+FKFxdnHfB+Tcjc6mdZUf9qcaRGGeguec2ORjndWeephhyWgI7VqRy14QoptFctyQUpvI0c7
	qFlHnp4F4xAD7uIldrVtbhUxz3HhIQaF9Xb2SLLx0sOjkeOZlI/nn0UZDFY4V5BYuLodV4vFXgu
	HQQoMP0lgXmj6ft
X-Received: by 2002:a05:600c:b85:b0:488:afb4:b98c with SMTP id 5b1f17b1804b1-488d68b3827mr129827555e9.3.1776168460348;
        Tue, 14 Apr 2026 05:07:40 -0700 (PDT)
Received: from hackers.camp ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1513csm51560435e9.2.2026.04.14.05.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:07:39 -0700 (PDT)
Received: (nullmailer pid 9702 invoked by uid 1000);
	Tue, 14 Apr 2026 13:46:48 -0000
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Joshua Peisach <jpeisach@ubuntu.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org, djwong@kernel.org, adilger@dilger.ca, xiang@kernel.org
Subject: Re: [PATCH v3 00/12] ftrfs: Fault-Tolerant Radiation-Robust Filesystem
In-Reply-To: <ab7zobowzvreloffpvua4orlqf6tecvczqwxvv5pdjn3wplnod@4vy7dp32elia>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
 <bxgqldv2abuadh3gweymib2co6gfor7sgpbkouznj6jliyblfq@42xw4jviodeb>
 <DHSTUKN1JCDK.2FO2HZLZLXTOT@ubuntu.com>
 <ab7zobowzvreloffpvua4orlqf6tecvczqwxvv5pdjn3wplnod@4vy7dp32elia>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 15:46:48 +0200
Message-Id: <1776174408.705089.9701.nullmailer@me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Tue, Apr 14, 2026 at 12:28:33PM +0100, Pedro Falcato wrote:
> Yes, a paper is provided. However, when I asked for a usecase I
> really did mean: "is anyone going to actually use this?".
>
> Good answers (IMHO):
> - "Yes, we have a couple of planned users for this"
> - "Yes, this has been maintained out-of-tree for X months/years"
> - "Yes, we are using it"

Fair. Let me give a more concrete answer.

The implementation is currently maintained out-of-tree and validated
in an arm64 HPC cluster running Slurm 25.11.4 on Yocto Styhead 5.1,
kernel 7.0. This is an active, working deployment, not a paper
prototype:
https://github.com/roastercode/yocto-hardened/tree/arm64-ftrfs

For planned users, the target environments where Linux is actively
used and where radiation-induced SEU is a documented operational
concern include:

- Embedded Linux on nanosatellites and CubeSats. The MOVE-II mission
  at TU Munich is the direct origin of the FTRFS design. Commercial
  CubeSat operators increasingly use Linux-capable SoCs (i.MX, Zynq)
  precisely because of the ecosystem, and SEU rates on MRAM in LEO
  are well-documented.

- Robotics in high-radiation environments. Industrial robots deployed
  in nuclear facilities (decommissioning, inspection) and planetary
  rovers operate in radiation environments where silent bit flips are
  a real operational risk. Linux is the dominant OS in these systems.

- Space HPC. There is growing interest in deploying HPC workloads
  in orbit for Earth observation and AI inference at the edge.
  European space industry players (including Thales Alenia Space,
  a known Linux embedded user) are actively exploring this. A
  radiation-tolerant filesystem is a missing piece of that stack.

None of these are signed contracts I can point to today. This is an
RFC, not a production submission. The question for the community is
whether the technical problem is real and the approach sound — both
of which are independent of whether I have a purchase order in hand.

The radio silence you mention was a process failure on my part.
Replies to v1 review comments should have come before v2, not after
v3. That is corrected now.

Aurelien DESBRIERES <aurelien@hackers.camp>
