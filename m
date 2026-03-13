Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4026B971
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410414; cv=none; b=lYaHgwAHFsnZYE+F3A2P9vC6HwiDTlhmqvQBZFjutgiDK9iwf9YTv6O8ZwGxmsCgGzK/FmY2BN1pHv9YGk7NfrA/rgHGedSZn2/MXJFvHyt0wQ1a1qXO0zwwDuQO3S4iYJ97GURibQ+dNNoafTJ3PrBj+v7nAO9LYT/TMTk6l3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410414; c=relaxed/simple;
	bh=G7Pg42Ol8fpAqManfW9fLFIvzSBuHbEqB5mrH7+54/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rdu7bQVBT+B9Qtv8+rA5B7uQCEfsw7Ia+brdG+5og9UXQsJMhrC+Nh51ReSPS/xG/Ix1ZZzVUNotLJeSIej2RwiS9OvPFJPb4n0CPL0n+vj8MhICrwYFq0gGB4nmfARfzgAF2WqeI796sBFW851O5ZPJYCMbBTDYiv/J0BrPMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYOIQK5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYOIQK5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9406CC19425
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773410414;
	bh=G7Pg42Ol8fpAqManfW9fLFIvzSBuHbEqB5mrH7+54/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lYOIQK5nIZl/cqTsijCFRf+iZDWVC/co9y4rqlCcv82bK+hbEegBa9VgjJ5N/Fs1z
	 zShpJJp8GrXcjR05BLgUgIDCYshVDi4oovGq0C9w00ul9HX4E2j+XGPjpLpuPWnJj8
	 asY2dA+BgFguPg9aSk0NZ/gfwoo4luhlhEsR6OOFYt7dGevj+tc1Y3aDMOhvn2G2ic
	 YnkgDQ3fr3vG+pPL7yaM+9Y26jSa5Vj6fe4MVAYa/XFpegPNknHIUf892656qwUk/b
	 4YOPbNFd7BCM5JvB1KleDdpWex3dFSOF2USSL71V7wQFyn1s6jPHSCoPJjj61UoxeU
	 Asyd5cQzpK9XA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b941762394aso275550466b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 07:00:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtzficKa8f6w84H9sYYKEpIMx+yRmjGfYll2krQ4KT8Uj/BtM1Tz4Z+YWSBJrj/pJmcalg4BPCdR/Qpimk@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxglYL7bvcgc7+9K2BPFbruY7OEj1KmdRuOfu1psekyjXY1YR
	6ejQaYv+PDQmmIRwF58YbxGVSvX6gAODGOS5pQdwAiDQ2HCTtI9P+NvvXAg5vT6Uwnzdh50P65Y
	2xDUPjAU05CDkqQVGgFfOnkFbAE/o6Ik=
X-Received: by 2002:a17:907:a0c9:b0:b8f:b32e:e196 with SMTP id
 a640c23a62f3a-b9765141719mr211056966b.30.1773410412854; Fri, 13 Mar 2026
 07:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311222613.2010177-1-dxdt@dev.snart.me> <abIxl8XEftpku8yf@casper.infradead.org>
 <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me> <abLUQECuMuxHNXjZ@casper.infradead.org>
 <20260312150623.GB1742010@frogsfrogsfrogs> <14dc2f67-7916-4990-b1c4-5d442c5d51fc@dev.snart.me>
In-Reply-To: <14dc2f67-7916-4990-b1c4-5d442c5d51fc@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 13 Mar 2026 22:59:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9_sUX8X9LWq4_MR5nN8CoBLtz4XayMpYduwyB578_jMQ@mail.gmail.com>
X-Gm-Features: AaiRm51tAToj9GQPFIwCZSEJv28i0tUHJ3CDiM1oXmhvhuhL_Of8957rSd5VBWk
Message-ID: <CAKYAXd9_sUX8X9LWq4_MR5nN8CoBLtz4XayMpYduwyB578_jMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: David Timber <dxdt@dev.snart.me>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>, sj1557.seo@samsung.com, 
	yuezhang.mo@sony.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> thb, I don't really care if the ioctl patch is accepted or not. If
> SEEK_HOLE/SEEK_DATA is really what maintainers see fit despite these
> deviations, I'd have to honour that decision and bring iomap to exFAT, I
> guess. That'd be a lot of work though because it mean will the rework of
> the entire exFAT code base. Not saying exFAT doesn't deserve iomap but
> that might be a little over my paygrade since there are thousands of
> embedded devices already using in-kernel exFAT.
I'm working on adding iomap support to exFAT, and I think SEEK_HOLE
will be able to address the requirements we discussed. I will bring
this up again once the iomap work is complete.
