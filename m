Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171B402BB9
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543159; cv=none; b=VYyCE9PjiNOwybJPVioTxXxyleFXZ+LeFqoaRRRBpzfJznpS01UsVLFjv/il1MCsSLIWWlCSnIIWvjVRuaxoEkDVrAfuyFelsLmP0+FRfA2cAa+yDJw13vHzlDYa032NHry+POS5vFrCFy6UaPeB6u3J3eGxkE8aYeGkcrpYGBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543159; c=relaxed/simple;
	bh=RwwG50AFVlkpovlkMUtr+9uYBBV9Ak7uoUsRpIqHc6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBDLrRjllytXvcRQzQD7J70qqWaxWmGUbDtZizWQtNg0B+KAm+ZwWoAxVOVIUG3lKmYXoIsdGDPeBc4nH6Rw5yq7GbhH03/AFEGySONhc4od3yKk0G1Vu6f2Kbo1hIJ1+0tkk7CLPZ49u0mRYHzTfg+eQeA1Xe5w2fG1FfVKXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qk+UMjit; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qk+UMjit"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b98652f05so428234f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774543156; x=1775147956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ImNIaV4bbLoPzNNN2Q5MhJAif89aZ5nZdsiuQaq47GM=;
        b=Qk+UMjitd8PxNyv2Ni2ladHpynVQq7qhmo4sQoAB8sCw69D+dYRGRwbnOubBklCaIe
         TTAyI4hA7q4bQzigjOViZiKCy4X4AxnDprP09bYcplWx6H/3sk0ngvtNxElk252hwXoA
         K4IF68lo3DJk3bSDWBKrJsqnte3l6MmKHm1F47rIYpkWPCyTMw2HKJhcSl6JfK/hv3rY
         2l4Tl7kyFdWYMQ7NjcT1BBbjfHzlAu7bXSy7i29VmljvPGN2w5YUZplKFigaTtMPzgXJ
         4n7QvYDaZtHcxQSb0Fo9iDAuH4Jbec0QS1w8fXUXIkW8PoVgq3d3Z5Ocx5CqNOW+xeJU
         Iz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543156; x=1775147956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImNIaV4bbLoPzNNN2Q5MhJAif89aZ5nZdsiuQaq47GM=;
        b=UhNVnDOAVrp+GdDlx547vSZXVnbGXQYWz1Z7SbvmZbauwqo36NTXf0DRCmwcIG5zoR
         qgIERWyue1PfGZte5k8v8su2gMURUaWRFNJudz1HWFs9FDYuB3lMEKpRfu3lGBXjcCLr
         MxaxXZZUGlRorNLFDe6w2kqj7vsi9OOBJM1CPiBVImB+adTOwxZPuUTtIX7Q405ozO7U
         V6iGRHGjIQKssLY5QtvwwZqO7C40n3Sa0pQNmLMvgcG8vw+puYQExhhAzdvdvhnepiFs
         TzsZ08q33+bL7XiiWI0P4hS0EYXN85gFAEZZys0dA5gmF/u7iHDGS0uz3xHbfRunJQ4r
         xAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnwBbCxbHUgYQzsnlumE2YZw4XvkN56axMuoMse0x1xMvAi3I//cStXW1TKmlRvQzDJH+3Gh+njKNdzK/f@vger.kernel.org
X-Gm-Message-State: AOJu0YxfeHaRZXpsdda3zfSqdjPVDh4Hmp4Gd3wW8/vesLY6FUFMQQmi
	gfzYkHAakE/Gc0azYO0xkuDsGI0N6glzF9NzGZY6AkO2KIlMqazMIr6id5LYyo0ev/4=
X-Gm-Gg: ATEYQzxZl5SGqfqr9Nz3P4K6wCn8hrMD7mZmu6sNHH87fbV0pvpsqt9aQQs30wZrNUa
	hjnCpMCX4+dZLw2hbZ2KDMZtUrA9L3+RR9qpEECqfeXibzWXVPiee2fu6fwBe9TgvtBQ3B4ZkIV
	tAANWiIsgC5zvGLHhcjCc1tsCdIsoiciGDxC5JsV6ozxtBSngUPJSHD1avdhKDLjOGzkgASOpyx
	RhE/VYSpUifzbVlOe5m27+Bce+dEOabRmz3PWo9Bywo87B9iO6FZSruSlhyIebtNSSc92WzOeXp
	OzXFOOEumoPqeiPsOMI60BMtOyGArMHdRYMhFMJJSrHvGw5MN+oaeSF/AVtBscMWJb61T9mLNAj
	KJwD+Srvqm1A9/CpFd8jywgLUm3ya1tbvbCgc/MO/yjFOqWSOSpLiUVfuA/zkOHnOxhsPh+dUF3
	jSKSdh8dEAjM4IGcJmGjgeP+rhcg==
X-Received: by 2002:a05:6000:290b:b0:43b:3bed:f3b with SMTP id ffacd0b85a97d-43b88a0fb4cmr11381427f8f.34.1774543156417;
        Thu, 26 Mar 2026 09:39:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3e8sm10040679f8f.5.2026.03.26.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:39:16 -0700 (PDT)
Date: Thu, 26 Mar 2026 17:39:14 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Disseldorp <ddiss@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/6] initramfs: test and improve cpio hex header
 validation
Message-ID: <acVhMv8iY-YsPxEg@pathway.suse.cz>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>

On Mon 2026-03-23 15:54:16, Andy Shevchenko wrote:
> The series that introduced simple_strntoul() had passed into kernel
> without proper review and hence reinvented a wheel that's not needed.
> Here is the refactoring to show that. It can go via PRINTK or VFS
> tree.

I could take it via printk tree. But some VFS maintainer would need
to ack the first 4 patches. Especially, I want to know whether:

   + They mind about the switch from hardcoded format
     to "*fmt" parameter (1st patch).

   + The behavior change is acceptable from their POV (4th).
     Might it break some userspace?

Best Regards,
Petr
