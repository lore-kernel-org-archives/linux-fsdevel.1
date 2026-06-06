Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37906299931
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 04:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780718686; cv=pass; b=hBf7ReF4DZBwC1FRj6zfjhkAk1G0O9AA5s+bjZbCPzSy9dbK2DHRV4YXx0LBOpC3tlRT1+q+TlHDmD3VpkER3oPjNB0vJcuuOYg+J3rPslgDqjplDC0ghh0gyjfrc4C14mQUlkkCiTIn2Vj876CQfAC3WNF+RH5UXIXvh/BDkmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780718686; c=relaxed/simple;
	bh=/kolzi35RAkOWhd/0jJm3K8g2kKO9ZjRvO8Ed1IyFY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEvy262waHq0ijxX4SltkPd3EK/JQ0GvUliB67XK5sN30hyq7J7AGlso/sRv5KdlD8izPVJowSq9YJThman1hCzq0TKgItIKtLB4khyM5uf1ia8LV/DSBz1uFyyagqJ7GoLYAp5HQUNrAwij5oTMcvnXRQ9X4j5lJorpGNkxsdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUrG+71G; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUrG+71G"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-660ea43107fso2795843d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 21:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780718684; cv=none;
        d=google.com; s=arc-20240605;
        b=bpP3XaSykBHGUd4XKOuvpcvHHZcG2RmgyuktbcoPiipALcAPo9o/PbY/9BLCe7F2G/
         n5HPBZvH/P+agCwbSxlBcbK7YTIQORrYeKfF+O2x85pLXQEGOnY1zdOCWuN0G64iR1Og
         5Hg+tVZZ7ZSRLc1JGdn4OjrV2Ev4c95NmOcfHzlBCZa8GypeAp49aBSAqDHVxctgHAXg
         CIC/8URMsuFVZeYZDeEt4x9D3WfxD7L2DxX7KOES0fn81XAGoRv6CXKYzXlyB2rJGxV4
         EwPwaXn3snfabyKzQVS0Brv+L25SNR/lmdSdoWQ2cL0OECP1LW2H5yIB0QDbj2/RVWWX
         cebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q5nyw30xxOLFYvDGydQHVhIa2yDgTqTxsxdE4HUTuzs=;
        fh=R95MoQ7n1EalqFAoFrqcuPZM7AX5dlpny0LjULrbVRg=;
        b=KHa71WuFB+iQ9hfjvkDGUp6GW/pQ6YqB24XBQnFtU8D4Ly9uWl6VHhdSGFGpWVW64H
         WBokhOdb8SJd7oyfma7LEbo/3bSZE+n2+/B3Sf48rEdzNPi+jiWTktAL3rEikmK06NGX
         0vfbB1FnYhIKkpGBD2QD+mPfrTQgVTVXiO8R9qK27tXh/+hIF0SaP+LhvV0elp7ibHL7
         vH4iaDlLPsAY42qyzVC0f5zvLWNm5aUmZITCP6ZYogvxXujglkPN0rOjElCqZqnblri1
         bVtvIa62UxZWpnAoXU+6BxkICjNG0b/s3BVzNv9uKtmmNXAtfcZDuwVlVyCINAtJSGsB
         7dKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780718684; x=1781323484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5nyw30xxOLFYvDGydQHVhIa2yDgTqTxsxdE4HUTuzs=;
        b=BUrG+71G075P/ISsylSC40dBYzafy3ohWdHFhiqVpQs1IbWtznDxAT3GdwIHF/itlf
         PmNUnIzWeDlaF7+dCHFeYoBvkQRT94HDaPEiyUG9ppdlgqL24hxH78WM4Nr8O9qf5tio
         Wv97G5bEC8l02gH/CAHaEbHt9um/2Cqrxn/uFKHPVZ4Y94MBrgF1YrQOBLICCmpI9SuJ
         FH8dCWp3099+iqm++Lfe9FEpeH6s1CmZVfleBhRyTKnjtoOv9ZGVfP5QUavGUupKwCVo
         sbEIaoCWpieYmI+g9U9V0PqfujyTMlI0SX5uPlYMOCY61e5GN5sZUxA4A8X4pZI54kHa
         /gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780718684; x=1781323484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5nyw30xxOLFYvDGydQHVhIa2yDgTqTxsxdE4HUTuzs=;
        b=B/wPfxqveP3mIEZXCGkj8VhtXdCi6najGOdaE3AHCeg7qf/xFbdM4xla/QCqH0+Qzb
         T0h/ITx2XrBtqTYsE6qIFccisTLoFWmbdFdRsBuReVybc4nvGfDuyUDAkwDzNPbvVjRe
         c9LKnmo7sYP6hsZ4+beRTOO+y6/ayH6UMilwYmqAGsae+/mAC4vgRfTjqVc2KYT7M7go
         JVghKRXE0ajmtWK0n+xa9IUiMiV4wjraTtgLgPVBvMVwYoZbb2dUWXYju3OIPCm9kZ9h
         JAgqKJkwjSCuvaLSML84XNMdi8xx2JJgY7yxthOSz4KItJggysopPWDmGTlDy8skYATx
         +8SQ==
X-Forwarded-Encrypted: i=1; AFNElJ+iDQbI56rez4f8T3Oa89EEwvKCJjJiLqYrpm1avxk0aPxcwxUAkMMBKo4l2S1G4wjQa9PZDZqJfWBlXJSn@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKZhRv7kwzTWKlj6EJuH3DmRVbCO5q8eHsb+rpb/R7FASpUUV
	ZQEVNAb7KbqoHDki8Juz+ZG5MRK5Ss0kpUZm0z6qxFORFFVhHt8MsuyP7eqM3mbolCuxevc53zv
	v+VI17iracM9EtIAQByp0TDLNjU0QXts=
X-Gm-Gg: Acq92OFdspr35T6eqCxS79XxQ1mPPTpBWo3huDfWB2UcSKl9h2ANc30uQvMTE49pn3r
	KT81xFaOOLk23wVNTL/l2jx3Bl4kIPR9lQtTY8FbWCDb/kUCGbyaboJl9SODox/lcoI33wmmHSz
	uaa0aXyhRbyrus3b94XpyvmvkT9FC3HI0kDRQ6ZsyHrKDdD3bmDGfqb7bSor6W5TXfj9gHls2ZN
	xuRzpiNLPxbd6IB3r+0trS8L+bJnPZPiSAPXJuXev6dn42KzwJ25G5IU7y97zaxgWEIHUTfO/Hu
	O1YUh+mkhnFEtAjhXQ==
X-Received: by 2002:a05:690e:4388:b0:660:8253:b836 with SMTP id
 956f58d0204a3-66106dcf1c5mr3499348d50.5.1780718684138; Fri, 05 Jun 2026
 21:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org>
In-Reply-To: <aiOXiumEOIPOQm93@casper.infradead.org>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 5 Jun 2026 23:02:44 -0500
X-Gm-Features: AVVi8CcTKe8nUPwkHKM-8IJXRSL1KyCbccoKOcaMpCJ8JQ7Hhm6cDDqx8lFblxc
Message-ID: <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
Subject: Re: [RFC] Maintainership of the EFS filesystem
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:44=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> As I said, I don't see the point.  Do you have any EFS filesystems?

I don't personally have any EFS filesystems but that doesn't mean that
others don't.

> Are you volunteering to do any major development on it?

Like I said, we've already found some problems, and like I said I'd
like to fix those before it becomes a FUSE as you suggested. So I
guess I'll volunteer to do some major development for it as well.

> Why shouldn't we just delete it?

Because in my eyes it's an awful practice to just delete something
overnight (probably not your plan but still), I think we need to have
some maintenance for some time before this gets removed.
