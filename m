Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D93D1CC1;
	Fri,  3 Jul 2026 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089439; cv=none; b=qYvZ9wpY01BvdrL+15PeARwn6vBZBO1TWY2OlioYGHViDXLwRwTDlbdZMMwbCePxONCjb8dNXisOEErimwdTEikbClnbHNJoKPmsaZA4dKj7irtfrYbxoZ2NjkguMnuNqk0BiANySaWEju5kHzcj1AvLd18h1YJW5d52uiZhVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089439; c=relaxed/simple;
	bh=0bYcjdMU8nZjeGHjRt8fT03r0N1EGRblyjn1+jFpPmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK0Pk7W4hKKwslvWONL0Hu5LpB0C3asTzQ5cvf6v3ZYm2OYgfq8sU/v2cPz2xifpWpngxY/AVtoNvbNxCxWo2gP3ifDELWVfffcWH4C7/sxnXckvazZ+3sOXba9gSf7dW5yZHJqviIz9u0ROJEDtjii+qdSyqc7NzVqhcRGFL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=r/H3NdDt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="r/H3NdDt"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A4A8914C2D6;
	Fri,  3 Jul 2026 16:37:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1783089436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pA0/ba17RWp2ZgWnK76QRKy9Ps5y3w/m9RWFXMSbtdM=;
	b=r/H3NdDtU/W3eEL5MJVLYpKGXX3WAlu/ZfXGdtMGCekrFnsU4mR3tF10SYaLYaLpxlHqqN
	k764WxSImkondWR1WRs5/OBgtoAI8HwgE79rUG6Yx/ooJmfWjPaXNNoyfs2Fa8dGs+d7Gb
	SDHiqKH2m485TEvpPNQKePy6Bmyu4slExCSuKoeU8WdCJ6w6bNKixds1oavyud/bukdv3S
	+uoKnueXbngjJCppk7CA1GhPt5nkV/97lcLw2J2zD0zzpIcyNVZQLuspGZrUXxeYm4TXgM
	BN0h7uhoBBVo7Rg+0IAhz/bOfkXSW+beMDGLb/RX4tyj2AmoxHtNCFZsM+pGNA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d63071f8;
	Fri, 3 Jul 2026 14:37:11 +0000 (UTC)
Date: Fri, 3 Jul 2026 23:36:56 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>, David Howells <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v7 4/4] 9p: Enable symlink caching in page cache
Message-ID: <akfJCNdLhWX8RHYk@codewreck.org>
References: <cover.1779355927.git.repk@triplefau.lt>
 <982462d17c0c0d2856763266a25eb04d080c1dbb.1779355927.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <982462d17c0c0d2856763266a25eb04d080c1dbb.1779355927.git.repk@triplefau.lt>

Remi Pommarel wrote on Thu, May 21, 2026 at 11:40:32AM +0200:
> Currently, when cache=loose is enabled, file reads are cached in the
> page cache, but symlink reads are not. This patch allows the results
> of p9_client_readlink() to be stored in the page cache, eliminating
> the need for repeated 9P transactions on subsequent symlink accesses.
> 
> This change improves performance for workloads that involve frequent
> symlink resolution.

Hi Remi, David,

This is similar to what is being discussed in [1] about file size not
matching data in sysfs, but this breaks symlinks there as well because
they have a size of 0...
[1] https://lore.kernel.org/all/akfHGcqke9qixd3Q@codewreck.org/


With /sys exported with tag 'test':
-virtfs local,path=/sys,mount_tag=test,security_model=none,multidevs=forbid

Then
# mount -t 9p -o cache=loose test /mnt
# ls -l /mnt/class/net
total 0
lrwxrwxrwx 1 nobody nogroup 0 Apr 30 22:07 lo -> ''
lrwxrwxrwx 1 nobody nogroup 0 Apr 30 22:07 dummy0 -> ''


I think we could just straight up ignore the size for symlinks and just
try to read it like we do with cache=none (that still works)?

OTOH someone mounting /sys with cache is likely to get rough surprises
so I'm not sure it's worth spending much time on such bogus files,
leaving this up to you, but wanted to bring symlinks up separately as
it's a new feature

Thanks,
-- 
Dominique Martinet | Asmadeus
