Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2C2F619D
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777007270; cv=none; b=omaZ5NfKdREuOMV3GXBwG8MvqBeM01cH+hDUaKVAxPRgLOLeXcuJp2LCxM1MKrGJiXe3QOUnHZrPBR1Dfdoek+cxtgyId920YhZzU3sv2lMGz2MLMDrHC183NxG/WnnuSbHR6fEtZxBdNCsLOjt6Ix397P1KA+z+BupgB9cilyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777007270; c=relaxed/simple;
	bh=xjE9giv7tBRG1qaYQTvNP0u8qwf+IGSEwMfTzYr2PSQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=fB0Yjek+Fv0VIdVOLeMF5EhAYkbZWtninqm8U2yWriXgVVVYakMQDYnTWNJwfBJ/ltt51zFJq98Dyi5Vj86mN434PCNXRq9Kw2Cagn0rXxfkmOQbsFAm6xAxRJwSQiQHg/1FTyLIFAUnjWbVfbKCbPYV+exx+lvZ0sSPuZldx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8WhI9gB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8WhI9gB"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso5192989a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777007267; x=1777612067; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUFDhoYbNqo8dXYU9en7BHWBBYUPonRzR5+Mg8X7c5M=;
        b=C8WhI9gB64nKmKFNu2IIgwL5+uw9cdtVTyVvXmR4B8Nd8TFmWQyOZdoX9kAmP2GNWJ
         cdYW2V7CqkVy/fgtjLnNvALeQJP4FxxyHEzFL3VN6LUgrWtkjqNPXV+aMGx7vdTVijz/
         jkRcDBBxfn7fR9IHLZfdQRRzF6zpHdoeipom0DQnO7KsY84TkGRzj5nEcoLONdhIv0ZJ
         BR8l7jFrbrbcl5Tx21iu4GVRsOvi9JXuATiAQOgvM/CPrtDIgAcIcOz6K0FlQeZe/gSZ
         bazq4Gjt0oKtzzvm8Ffd0X0pp7yz16y02XS5dIHphtH0sb75XrH4c6jfg6hZvonGdXw0
         yjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777007267; x=1777612067;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUFDhoYbNqo8dXYU9en7BHWBBYUPonRzR5+Mg8X7c5M=;
        b=Kaz5DF+SmbRzoZO6qSu0Shjmc/ch7e/yQy8jWpH/d1ZiB1NaWO856xXYi3iR96BWoE
         Gb68PYPkO2mCe50WqQXAK8JvSpfT9Zq4Yr/MldasrrRPfNcfr3UD4riWH/w5c6qc12wj
         ulVlAwAG8VC4DUoTJV9G2NaZP9sJFq5TkHoKIdEHL9wsJ2hcmeoIehW5Torx79ml7dCQ
         1Z3kHWVNP75vhbu+EPwjON2l2uNikGL4bAyKJJsLXca61X1XwEVvPYNGziyezaHTSI+M
         N8UiGwMwj6MD7R8e9M7q5xcBdTsN5aq8+ANhI32WLRxfFVQ3CTCnAY11ugx5TGFwNpTn
         /lSg==
X-Forwarded-Encrypted: i=1; AFNElJ9uzk2fLaXfHTWT/U/KJ+6J1IGkjSvQjDxEhi6fKcca13/+jdYvN1Z9iUEi7HFFdTR4JgwHszXpx+hcAoSv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7n3qh1ZGng4cSAqiBv6+3zPZIIJdtgexxIhnYBWHjT3cCiL9W
	IfQv0Jw0ga5+fJL2MlQcUrhpO0cEZpFpFFm95XTNObNnSUpnr0J5YkjKntMO6Q==
X-Gm-Gg: AeBDieurdNLWJTqD5nU1JBWPBMJhP0WjRoq34lOfzq1NZBJQE43Q6rGo3tNA6VAOo13
	7U3VZGwEY6X6bs7hN8BCDBFtUr9492jnS8EGM6fOXN8LBDn4p7Q234mgmnLwRbkE17zrMm+pcKm
	Evc4V/+vs6+FyJ2jnpxrhIGyrr5vMWw9/GlPkgzOtg581/fTIwSmhlz95mIBPBcF22KC9P3wSUu
	0Am51IS9TS8XZ40Ax4R+ZhC/76dP6Z8/vDGtlYPCwPQ3smqjMAxmhwglqhXRLfFacPTRJyKb+4Y
	qwUp1FztXkuEn/0S5S0cFKhz3nqDkl+WRNmi1CpXQ4Fi2Iu8WZItxpua1FsCvedTc2CrmgUuPBn
	Xu+T9CZI1O5chU5su1zkG+seMkHZO3UmQXLdqinyXzw+SFDJEOXT16YOz/un13cqd5qRIviSStC
	sQoGxFJXD5NVHiZcXOLqCwDrTBD7aD0f5kg+EyLFUeiio=
X-Received: by 2002:a17:90b:5890:b0:35e:5723:85e3 with SMTP id 98e67ed59e1d1-361403f12ddmr31417110a91.9.1777007267369;
        Thu, 23 Apr 2026 22:07:47 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fab1c32sm8342149a91.5.2026.04.23.22.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:07:46 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, lsf-pc@lists.linux-foundation.org, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Pankaj Raghav <pankaj.raghav@linux.dev>, Andres Freund <andres@anarazel.de>, djwong@kernel.org, john.g.garry@oracle.com, hch@lst.de, Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
In-Reply-To: <aer0wd2Ig0hjN3R0@casper.infradead.org>
Date: Fri, 24 Apr 2026 10:20:27 +0530
Message-ID: <v7dhrmgc.ritesh.list@gmail.com>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev> <wlxxrx10.ritesh.list@gmail.com> <aer0wd2Ig0hjN3R0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Apr 24, 2026 at 06:32:03AM +0530, Ritesh Harjani wrote:
>> We were thinking if it is possible to extend the Buffered Atomic Write
>> session into two "continuous" halves of 30mins each (total of 60mins)?
>
> This is painful because you've requested me, plus both Storage and FS.
> FS has lots of space, but I don't, and Storage is also pretty full.

I see, sorry about making your (and PC) life difficult here. I know it's
a lot of planning :(

I think, both FS+IO folks will be interested to discuss both of these
topics. Do you think breaking this into two discontiguous session help
us plan better maybe? In case if we don't have any continuous slot, then
maybe we can split those into two.

>
> Do you need me for the full hour or just half of it?

Although I understand buffered writethrough is an FS related area, but I
am sure a new writethrough I/O path is an overlap for you in page cache
as well :)  So, yes, it will be good to have your feedback on the second
part of this discussion which is - buffered write-through for buffered
atomic writes.

Thanks again for considering it!

-ritesh
