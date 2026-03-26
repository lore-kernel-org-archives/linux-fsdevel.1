Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64725378D8B;
	Thu, 26 Mar 2026 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540314; cv=none; b=m9w6qDNm/rB7iSWOnnWbK9NxmLOspTmlnz2vXltaTTM08ANODBW5Zv4OoXu6GBJeJGPFHQbIhhLCH+x6nATq0z92RpMf8NyKsf6Tl0TCQIg5Lng8Ohd3bfTImsp5X+OO/rekpq+TZanfgTKSsGAKipw6KEWIjRoiqhCe2Dvyx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540314; c=relaxed/simple;
	bh=K95S268P3m3xmd/LN8KS38xzkNrMW8+0DTYA+JTEpSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1R0+8Z5AU0XTbMka7gUytLn55E8flXyjfFMtSNhh05mT2NK5SyUGbSHx7b6D0w7c667hEDTXhfFm4swci6lpjlAdLjFFxT6W3LCaIz6gVm2ZJov28pzKIpFwCa8bIoV627Nwyt4jgyN1BgrN2MZsL+6M6/TDaflIC+fhCiDELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (108-141-067-156.ip-addr.inexio.net [156.67.141.108])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 0BF1FE036D;
	Thu, 26 Mar 2026 16:44:02 +0100 (CET)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 26 Mar 2026 16:44:02 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, 
	Horst Birthelmer <horst@birthelmer.com>, lkp@intel.com, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>, ltp@lists.linux.it, oe-lkp@lists.linux.dev, 
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: Re: [LTP] [PATCH] fuse: when copying a folio delay the mark
 dirty until the end
Message-ID: <acVT7mE4MjBfNPOW@fedora>
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <202603261451.d2a4cd46-lkp@intel.com>
 <acVLK8F8i-eEZwLG@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acVLK8F8i-eEZwLG@yuki.lan>

On Thu, Mar 26, 2026 at 04:05:15PM +0100, Cyril Hrubis wrote:
> Hi!
> > commit: 47f8dde97f35e32a1003d54e387273bcdf014ddf ("[PATCH] fuse: when copying a folio delay the mark dirty until the end")
> > url: https://github.com/intel-lab-lkp/linux/commits/Horst-Birthelmer/fuse-when-copying-a-folio-delay-the-mark-dirty-until-the-end/20260316-234418
> > patch link: https://lore.kernel.org/all/20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com/
> > patch subject: [PATCH] fuse: when copying a folio delay the mark dirty until the end
> > 
> > in testcase: ltp
> > version: 
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	fs: ext4
> > 	test: fs-03
> 
> Looks like the test that has failed was fs_fill that runs several
> threads that attempt to fill the filesystem (until they get ENOSCP) then
> delete the files and try again. And apparently we managed to get EIO
> when file has been closed() by one of the threads after a few minutes of
> the runtime on NTFS mounted over FUSE.
> 
Probably nothing to do with the patch itself, but the patch will never
make it since it contains a wrong assumption.

Thanks for clarifying!

> -- 
> Cyril Hrubis
> chrubis@suse.cz

Horst
