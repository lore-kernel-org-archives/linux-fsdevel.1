Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46182DAFB0
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780868050; cv=none; b=m8hUlA4QPevmf6qe5uhN4ieTLi/zKOsaViqiPyNoIMjp25evt/FJ0NWegXnw3VTP3p59r/3izDPok0K4QKHXuE5DQCFFny3K5Y7GWhhTm/nWd2B+dNSNUhnZvix547ZoLP07PaR8CZOA10RfydCp0h4pJIJNA3Xm8QI0dO0ajc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780868050; c=relaxed/simple;
	bh=cmdmJeIxFqiDsscETUWVvp1e9n4ixZb+AlchAU+fpGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfLcPLUJP3r312hETZyGhm0jcCOqHSgxEOMLbk2QYXerhzCzzT4bi4xjdqNq64MS5Uwca2LNnk0WksZkmg6h+5SounT27ihskE5nsNu2rmuFoEcDEJvtyBwzzvHXqeitn4hJHvUP2/fGIPRYB464hA8r7YtopUQ8rk6Qrfy5D2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=m58UkRuh; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="m58UkRuh"
X-KPN-MessageId: 991fc9dc-62b8-11f1-afe2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 991fc9dc-62b8-11f1-afe2-005056994fde;
	Sun, 07 Jun 2026 23:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=IdinXQT57GCfrRGuxtDY6THEIYa5vpv8nUEvuOtZEkg=;
	b=m58UkRuhxwP8DyE/+/ciGX++uzJ69utMfPTvLP7e+nN6tT0zAPVctVkyh7P3Q+lP5kz/J/NJrR3kC
	 WQbHEVrKDNCRKJmrzdUL+qkJh6GfkJkxRyetWFcjOJc6E8sIgCzcdVGUJGr9Qyzw/u7bYEbbpqLkeb
	 21EetJPcOFu6NvHzSr5p2DuG93OyhaF0I84x67RfmAdbU2RSg9zqkMqaopFU0zS1/utxeIzPFxuwlh
	 hoY4q7JVSk/RP9kRGPvdZs6IJ4WKz9L6L3j9wiJ4hCWF1R3bzrPCWPyFYIilkLCBqCOWBwUYpv9tB+
	 oiEPkXfM92NcWqu4ujF0apkx7hwiSkQ==
X-KPN-MID: 33|fdiCb/ARKcsmc+ad11MaDX5q1DmkHuuHDAp2LvmcGeqEytpd0OjdUMRQBNK7pPx
 SMUO6pWBmGeba+UFWt/mVfo210JUy6Hg6z08Ol/ksX2I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fuieuI4CpGehUEnZ2pAuMUzsgAbllpnvJy1IKfLPMREj8gFnw1gIWfPLEV4AkSp
 sLy5jh2ob418WEDLFTu2+tg==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 99017f13-62b8-11f1-bffc-00505699772e;
	Sun, 07 Jun 2026 23:34:00 +0200 (CEST)
Date: Sun, 7 Jun 2026 23:34:03 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Cc: djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] hfs: return -EFSCORRUPTED instead of BUG() in
 hfs_write_inode()
Message-ID: <aiXjK-DGeLE4MCwx@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
References: <20260607035339.1015062-1-davemadmaxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607035339.1015062-1-davemadmaxxx@gmail.com>

On Sun, Jun 07, 2026 at 03:53:39AM +0000, David Maximiliano Hermitte wrote:
> hfs: return -EFSCORRUPTED instead of BUG() in hfs_write_inode()
> 
> A corrupted or otherwise malformed HFS filesystem image can reach the
> default case in hfs_write_inode(). The current code calls BUG() there,
> which turns an on-disk filesystem condition into a kernel crash.
> 
> Return -EFSCORRUPTED instead. This reports filesystem metadata
> corruption consistently with other major filesystems while avoiding a
> reachable kernel BUG.

How is -EFSCORRUPTED handled now? The BUG() marks a situation that is
pretty bad, so maybe you don't want to continue to do everything as
usual (although a BUG() is very harsh). At the very least, there should
be a warning.

> 
> The issue is reproducible with the public syzbot C reproducer linked
> below. Before this change, the reproducer triggers a kernel BUG at
> fs/hfs/inode.c with RIP in hfs_write_inode(). After this change, the
> same reproducer no longer triggers kernel BUG, hfs_write_inode, KASAN,
> Oops, Call Trace, or RIP evidence in the validation window.
> 
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
> Tested-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
> Signed-off-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
> ---
> Changes in v2:
> - Return -EFSCORRUPTED for metadata corruption, as suggested by Darrick.
> 
>  fs/hfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 89b33a9d46d5..4192f660b64f 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -471,7 +471,6 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
>  			return 0;
>  		default:
> -			BUG();
> -			return -EIO;
> +			return -EFSCORRUPTED;
>  		}
>  	}
