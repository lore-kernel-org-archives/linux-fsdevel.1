Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB69509F17
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378015; cv=none; b=nybDAmwzS/33Hr47Uo8GjkECMD+h/dVpPNcE3QnxIP/cnfF2AwhUx7ycW32Axd8kpaPR04yJlmknrVOisbbzWdauDeEu3RiT7MYxVDeRCYMNfTF1hJlbJ06/3zCSTMtChVe/VoDpxQ9qoNzkIRsiDCHXVauZe+F9S12nmnExWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378015; c=relaxed/simple;
	bh=IHzywUCHO0ob7Ukns7yJ4Z4Dhpta9lJ6UZN308yPmHg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CCrT/QANANaVqSH5QESzRTStrXtLToVaSlc2U/tsLCO2FbAleUXmo0k6O/7jl1LLapmN7phBOlCf23uxGToyzvEntvQtvHeBy7vFl8voPE/dmZlvpX+zHepOzuB5QjZFX4yURQwuvs8uFE0rz4LXrs50Pn4n/WdS9ax7SiZz/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=UDj2z3dT; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="UDj2z3dT"
X-KPN-MessageId: b6dc0517-b936-11f1-a5a2-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b6dc0517-b936-11f1-a5a2-005056994fde;
	Sat, 26 Sep 2026 01:13:27 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id b6dae0c2-b936-11f1-ac15-00505699693e;
	Sat, 26 Sep 2026 01:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=b4cs3pQWmtJ0lv6ft+kCFdHthnWoZIwih0aFunzSbp0=;
	b=UDj2z3dT9YyLqqT965II8uA1WUpa00eNKfdgxg4RULFKHmF4wxFDYpRFP/0TxruULf9fKQjk1WlMo
	 xjM8ioKATExzV7Qr+oBJ/OFrJbZeCegFoT0Po+x+OsS97t+6v/gZNuyvYMIXjHxAdUxqdpQ3iN76uE
	 1z5BE+GKqXLjzRguCqGZgHv7dnKgtqqGi8SsQ/3mHOqwnDdtFZRYY8AFtoUQ2/jaDUwIloiPbEqM7s
	 O+kdhxaxfj5uf7YpCdUDwXnF5t/j+6ECgxOLESWVb+phstU99rCWLdt8uOueKkWLFAjRJQf3D58j1W
	 wHgQupPJkMQN+QWRulvhkMuMIi//PdQ==
X-KPN-MID: 33|SnyEX77jiPo3jdzb0R8r1R4CQ8JqpRuWlRDUnh63a/HJWF00fWLcSK/zdAGd0MN
 VFiGaGMS6ibYIOxFBjH3J6xn3VTkckWo05VaeAOHaRh8=
X-CMASSUN: 33|brvZ+V5WyKLsR+PX1wwd5weRmkU1MJ71tO/8scHW4cUUZX7DkFfyj6ejpFsmIRP
 C2Hsy8XO/II4/ptvnuuM47Q==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id b6d4addd-b936-11f1-8edd-00505699eff2;
	Sat, 26 Sep 2026 01:13:27 +0200 (CEST)
Date: Sat, 26 Sep 2026 01:13:27 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1131164231.213466.1790378007193@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 18-09-2026 04:17 EDT schreef Christian Brauner <brauner@kernel.org>:
> 
> 
> > @@ -4582,12 +4646,25 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  		goto out_dput;
> >  	}
> >  
> > -	if (!dir_inode->i_op->create) {
> > +	/* mimic operation missing errnos of vfs_mkdir/vfs_create */
> > +	if (create_dir && !dir_inode->i_op->mkdir) {
> > +		error = -EPERM;
> > +		goto out_dput;
> > +	}
> > +	if (!create_dir && !dir_inode->i_op->create) {
> >  		error = -EACCES;
> >  		goto out_dput;
> >  	}
> >  
> > -	error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
> > +	if (create_dir) {
> > +		struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry, mode,
> > +						       &delegated_inode);
> 
> So, I think this is broken. Whatever vfs_mkdir_no_perm() returns is
> passed to do_open(). Kernfs makes that buggy.
> 
> cgroup, cgroup2, and resctrl are all implemented on top of kernfs. And
> kernfs ->mkdir:: iop never instantiates the dentry.
> 
> So that means e.g.,
> 
> openat(cgroup_dir, "subdir", O_CREAT|O_DIRECTORY) creates a cgroup
> and then fails with ENOTDIR.
> 
> So the negative dentry gets handed out and now userspace holds an fd
> with that negative dentry. So say userspace does fchown() to 1000 and
> then fchmod() with the sticky bit and then you get a NULL deref. I have
> reproduced this.
> 

Damn, nice catch. None of the LLMs caught this, only our flesh and blood
maintainer ;) I must admit I didn't consider a ->mkdir that left the dentry
negative.

I haven't looked into kernfs yet, but does it make sense you can set the
sticky bit there? Not that it is a viable solution to just mask that out,
as anyone would expect positive dentry at the time of do_open(). Curiously,
with a very quick glance, it does seem that only may_create_in_sticky() relies
on the inode being available.

Thanks for looking into this, Christian. See you at Plumbers, I guess?

Best wishes,
Jori.
