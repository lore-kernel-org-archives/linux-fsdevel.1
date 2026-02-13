Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F12E7635
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771025976; cv=none; b=FawxvaFkOVLaxWh0phYi1gar4lknXUZg/h86yykM90w/XGko079i279/byxppo2JlCWSo5UoheJL5O6o2BtjbQ8RyCQ38s5zHShdToOHA9iRAzJu65bopzdZ9lhrE3NTh6bPuqERNNFrMFa6T1KumtbwtkB/g9MCoN17RNsaIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771025976; c=relaxed/simple;
	bh=cIijZJ7vBB9byXFCBB/N91Qv30Mpm7r/mBqhonjG1lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0cGXXfnrcIoWl60Xpwt+XMT93XFhtm0+ZYoNKVlHsoomNKAuxHNEsXx6pgigdd23UAEBO4aGIRaJB7Bms8PG7tWQkgfWXoOk2qxWB7t41sK540PjEYJqawBdBTItkR6CDmO36rhAw93dx4zJvx5ntuuuvQUqxfS9MNsMp+jzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wDbRsW0b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wDbRsW0b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ym+U9nm3ZHh38Q00bEcPAPKb8iVXeN+0zX8s6Dsh1n4=; b=wDbRsW0bRFA1rQI7pMqWfzwviS
	Lequ1cQuC2Z6bXSWEn+EkekVvc48yFyzhuPm7exjMkpvQ+IpJEY17ulKp5Rm+CXs06KdT5CiUr7Qp
	Ml0ma8Tc99bUKdDMRZvVpLJuY/tuk9t/fyvUzmmZ+SBTcV4kFnOgS6kBzcGi0wOZp+TZggWGm50C/
	t2/4B/GdFSQpSh1krrjv0mdtrUtE37UIqa///E235s/+a+xwQir1tCMqm2cOaPDeM3CpapPicOJWg
	arrDzfxd9ZfMQJ18MNHBo9+LG6XmlL6EWnRXA/uH1CUnz9h2Jh6+4+d/XLDBht0FGG3zZV2UXA4n+
	v6/TI5OA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vr2nD-00000003OHd-1SIV;
	Fri, 13 Feb 2026 23:41:47 +0000
Date: Fri, 13 Feb 2026 23:41:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Askar Safin <safinaskar@gmail.com>, christian@brauner.io,
	cyphar@cyphar.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260213234147.GS3183987@ZenIV>
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
 <20260213174721.132662-1-safinaskar@gmail.com>
 <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com>
 <20260213222521.GQ3183987@ZenIV>
 <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 13, 2026 at 03:00:49PM -0800, H. Peter Anvin wrote:

> Incidentally, how is . treated?

Explicit no-op at any point of pathname.  ".." is
	while dentry == root(mount) && (mount,dentry) != nd->root
		(mount,dentry) = under(mount, dentry)
	if (mount,dentry) != nd->root
		dentry = parent(dentry)
	step_into(dentry)
and crossing into overmounts (if any) happens in step_into().

See handle_dots() and its callers...
