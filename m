Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D52EDD62;
	Wed,  4 Feb 2026 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227457; cv=none; b=qQEG/s07wz2ZNCUErnYKPxCVs6SMoV8BT7Q59V7eaW8owwg48vsqS4FLGVvTHm4ytLa3Lw7Q/JmU63+Olaw+DfjXvnGVQLfVIb6nfxTbb5CbVamEEKBE/N78aIWwIJGpjj3HkFVAY+kicJmZcJw2DD0iQG76Dbdvre5GYCdkbnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227457; c=relaxed/simple;
	bh=wEbxbHnIZ7bupetIh60P+ae+LuxBu5eACAmT3K2aW9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6X0TaDfH2ZZ6fyv3+kisllTOROuSd049AJ78E6XJT8NTplXVyqDoWF/5tuiFn/mjuBS+je1iEGkl83jXLuwpdDSTaj2kUVgC8ciRuAzaqjn7BH7VNOvUL93A95iz2lghp4p+H0WMqRUmxPPlfTyS1DkYDiGTD/C4GUohOetcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JmyVodq7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JmyVodq7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9nBnh0gCf8h6ovmxwaDA/w3qUQ8obagfTnSenrVV5W0=; b=JmyVodq7+nRt9xXFICcj3FPLDz
	7iKOZYdjsikb7FV/tq7nzhvxjsCvegKKm24x+XkNtHjgT0Nq1wOob//cu7oE4La+V1GEZlUl6GJBM
	ePEKxNpnNF8Bt07qUaLLBUiWdocLw1qfOurcDAasOSQvfZJ9VlbIxI5XqFCPj1Nz6uBjqV+U/h2ue
	QNIkfl5n/oDDp4lgKDgxmUYMeUzYSzZcwzjGzAcQRXL9aTTSXcVYVQMbMSKL7gbxHm8NkruTzDZX0
	D7fnTCMHrHgvpnwti46jf944bORwp6hLTHiqDl4g2XExqHHBt6VDK9vtnPx65qB11t6F0dcz3D2Cw
	JjHM4U7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnh3h-00000005JDc-10vg;
	Wed, 04 Feb 2026 17:52:57 +0000
Date: Wed, 4 Feb 2026 17:52:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
	"syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com" <syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
Message-ID: <20260204175257.GN3183987@ZenIV>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
 <20260203043806.GF3183987@ZenIV>
 <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
 <20260204173029.GL3183987@ZenIV>
 <20260204174047.GM3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204174047.GM3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 04, 2026 at 05:40:47PM +0000, Al Viro wrote:
> On Wed, Feb 04, 2026 at 05:30:29PM +0000, Al Viro wrote:
> 
> > While we are at it, this
> >         kfree(sbi->s_vhdr_buf);
> > 	kfree(sbi->s_backup_vhdr_buf);
> > might as well go into ->kill_sb().  That would result in the (untested)
> > delta below and IMO it's easier to follow that way...
> 
> AFAICS once you've got ->s_root set, you can just return an error and
> be done with that - regular cleanup should take care of those parts
> (note that iput(NULL) is explicitly a no-op and the same goes for
> cancel_delayed_work_sync() on something that has never been through
> queue_delayed_work()).

Scratch the last one - you'd get nls leak that way, thanks to the
trickery in there...  Depending on how much do you dislike cleanup.h
stuff, there might be a way to deal with that, though...
