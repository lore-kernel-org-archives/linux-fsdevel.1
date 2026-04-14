Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2673E6399
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168722; cv=none; b=N43ljsamY3OmYLzYb5mii2LjnFBGjHRgOE5T7CKxAHXfpRi9W4Dxd+r00txb2n8BjLRxZzzuHILuEeJvkkHrRXK3IqC8ImocGnr7x+PPH5YZcXoaYSWXxkyOqDJQIWcI/9ybyQtI5uOif0kofyytU/uuAd09IXuOZx3lb36thQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168722; c=relaxed/simple;
	bh=EcyAyQAY07H09O3PSX0IfaghfmLvphSUvxDuGMY+c24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cIqs+xLKh48nv5STUjy8AKatgeJLLCJhSqcyRntK8rnBgdpNEB7OCi8DudR8cKPohncOG5vn5q/j/bJd1P7qWl3SUdjxDXW5QMfEvnpVd3Rrfr4pIvzNUMJRkn4hE1MP8f23YlqrnRbUHx/Ye43Ag0HkXUlp0vqceBGhTR8P0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488822b93c7so6120715e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 05:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168720; x=1776773520;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcyAyQAY07H09O3PSX0IfaghfmLvphSUvxDuGMY+c24=;
        b=kIE9j879j2wM4g6D9ZnRlyerwv8U2kJbm5kqItmUSF3zwfwKqAU2ghyRnqkcmozMO8
         tI6YFbSyDzy2POail33doz0vt50kbZRzgTG6M81zBymWl+9MPyG7cllepjL04LpSVbth
         v6Hfgei0Oz0+n1dZR4jmEvfKEaECElsobT7tr8xY9wUbJmIZo9weUSlqJtFzYiOJflgL
         rCVqDXOvBB5+iuBeVvlJbixvGvHQBu8gKp6x6iY/7w3v7LFxN6wUo6io41BOKGIkHnLE
         cGoeS8mjW9peBhgn3yofQAunJp6eVxzgqnoOK/D2Zw+1CPMYKk6PgZKjV+rDA5LEdtWW
         7UiA==
X-Forwarded-Encrypted: i=1; AFNElJ9Sb5A5214YoC3+TSskktORMcsNniWDSpgtXJxGXvXY3ACCKwBx20hpHyFSvmhVMzS4N2jhSPyrq/U5uQO+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PUSK6LpsT26ZAvD9z5xVWugbW6/hki+7hSMNbnSsL4oDIHLN
	VMrv+bQehVWfrLjXEe4smElZot/OaZTcAqMSywrSueMgpYllnAAvkGR9
X-Gm-Gg: AeBDieuz9ha+wJ0YwHx7wv//b7R0vFm1LLCUSpk/fyUYD/Fd44IRPtPRw+K233EQ0Mz
	jqssngDwlopmHfU/LFuH591vR3GUGxjHPf/I3WDzgmnKhbGR7KerYTUExkOqrOmlWGnQAZZ3uoc
	r+kK2rZgRU2RJvvv/svy/Cvirdxe1dBD6pmcOA8CatECWrkmqut4XJoL5l/EHVpP2RJKFaUtM30
	jG8Z3JpE5PMMOEET8HpgZtKkZG3mBR2QcSoRbjdpP75qjWjZ6s0LnzpajjiYmo5RryoneCvwrON
	AMwNy+A+Ls76h2M+ypZr6AqHIsmDOuLhskwHgoYLiclHgAESEy4rk7DiNmXCPB9QcxwXLuZIlib
	SZqqN8+Ihy9aLMj7Y/H9OXLYZI7ovySM8i9lR/wJ4uDJxN4QTRU6z9xxwzjfoTZCem+kf6Ot4zy
	0ZK+iQEbnxtNulyfX+MR4WCH6c6z3v31mLAIsJCp0NkTjd2U55lNAm8uEjcjZuqjq7mNLvH94=
X-Received: by 2002:a05:600c:19d4:b0:488:7e7b:dbc2 with SMTP id 5b1f17b1804b1-488d7f2509dmr120181455e9.3.1776168719869;
        Tue, 14 Apr 2026 05:11:59 -0700 (PDT)
Received: from hackers.camp ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5dc7070sm120255145e9.10.2026.04.14.05.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:11:59 -0700 (PDT)
Received: (nullmailer pid 12730 invoked by uid 1000);
	Tue, 14 Apr 2026 14:11:31 -0000
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust Filesystem
In-Reply-To: <B1515863-5EA3-44A7-BEC2-40A49BEDE7DD@dilger.ca>
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <fkf75lk2sm2nfych34jiyoeqfctwkirzo22coqsad72yeau7ht@mh36h7nercwh>
 <B1515863-5EA3-44A7-BEC2-40A49BEDE7DD@dilger.ca>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 16:11:31 +0200
Message-Id: <1776175891.864729.12729.nullmailer@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Mon, Apr 13, 2026 at 12:03:10PM -0600, Andreas Dilger wrote:
> Modern ext4 has metadata checksums for many years, and fsverity can
> be used to add Merkle-tree checksums for file data. Data redundancy
> can be handled by the block layer.

ext4 checksums and fsverity both detect corruption. Neither corrects
it. On a single MRAM or NOR flash device in a nanosatellite, there is
no block layer redundancy available. Detection without correction means
data loss.

RS FEC integrated at the filesystem block level corrects up to 8 symbol
errors per 255-byte subblock in place, on a single device, without
external redundancy. That is the specific gap that FTRFS addresses and
that no existing Linux filesystem provides.

> If code size/complexity is a significant issue for new embedded
> satellite controllers, then implementing "read-only" support for ext4
> could be fairly straight forward development.

Read-only ext4 does not solve the write path requirement. The target
systems require read-write access to MRAM during mission operations
(telemetry, payload data). A read-only filesystem is not sufficient.

> You also have to consider that filesystems are critical components of
> any computer, and having bugs in newly-developed filesystem code could
> be as fatal to the satellite as the radiation. The general rule of
> thumb is that filesystems take about 10 years to mature.

Acknowledged. This is precisely why the design targets under 5000
lines of auditable code, why the on-disk format is deliberately
simple (ext2-reminiscent), and why DO-178C / ECSS-E-ST-40C
certification is an explicit design constraint. A smaller, auditable
codebase reduces the bug surface. The maturity concern is real and
will be addressed through progressive validation - the Yocto arm64
HPC cluster (Slurm 25.11.4, kernel 7.0) is the first step.

Aurelien DESBRIERES <aurelien@hackers.camp>
