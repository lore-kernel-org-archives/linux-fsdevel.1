Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B03081A2;
	Mon,  6 Apr 2026 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508246; cv=none; b=fTk/iFZcLnGtvNeXyEEcsf2mUfnf16W55p2vq63z9Tw0OYqenm/POCaa1+ygDTLV+5Z9BoivYJ9MCTgzg3ZB5zHkNRqOaYAEnmGQdv20npqljsa5Ogd4LJYREpsFM2AlPZ4PFSEyxlZCbY3uHVNFonhlkcPyQmu0OqZDZUymwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508246; c=relaxed/simple;
	bh=cT+7QeBfiJNUNByrQ/cMO+juj3j91rwzj86e/A2Uu0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W08AFifgE1140sbzdb6ZCrylIZhyu4Dr3DSvhyALgkJMQRzv2b+MG/rJWRqUtEvda9yWOLbPuEW1grKUN6vB4iBXF9C84e1LkWHX3qJnKQ0Mmkhc2Lw3gzVWmKAi2+KaWLsDc+mpNkYB1mpiPyXUEV9ltBBb3hOs1MswbsnUEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=aHStHdNM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="aHStHdNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775508238; x=1776113038; i=deller@gmx.de;
	bh=8R8TzDvxqW68DeqQtc36ik6/IKiZvSSylIkFTKUjTOo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aHStHdNMj3FvTgZYJ9dRqXV9HScoB75Ts/ycYgQKs3Hr5KTEkrIALQuovlVlQ4hG
	 KeSZ+pqw6iiVglQB3a6igIUrD9jB9RZG2NrGVoV1iJFpsgo5dc8dW72itOz2gyZo3
	 JLgEtVYHaUVvBucJsrBDxbBO31BJoCYEF7dMJla7chuZ/yEQ9syl9Izq8BOQHBoX0
	 ShP07xRnXD6Ly1UL/+9KY2s6ZMw2gUq/BuEAVsrXOHVncPeVIq0194yAj2Ecenx3v
	 uCOqZo49GE9fTyuphcKHfpbFHLstnHd43ISwtwPRTLD22PjAhPsnFb/h2bdaRAa21
	 7Onco6yMRd83YwrEbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1vjcnm24J6-00kncD; Mon, 06
 Apr 2026 22:43:58 +0200
Message-ID: <0e4a8cef-2a64-4392-a5ba-f9f57de48f8c@gmx.de>
Date: Mon, 6 Apr 2026 22:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] [PATCH] Fix warning at fs/dcache.c:430 dentry_free
To: Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
References: <adQO8B0rkR2ftusI@p100> <20260406200733.GZ3836593@ZenIV>
 <20260406202829.GA3836593@ZenIV>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260406202829.GA3836593@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gcn6Gwp/UM7h6KeLSBrAABe+JqfI4sQbPvkAOmTMLfIsHDxUE2I
 iYtrWqFm8lriXnqcQPyn2eHIMAJXIivuLMcCSkR/sl6TV8PcJqxL6t2RKBmWlYguvukZ+TU
 eHHF+/WIf+r3e9WMJSDGhbN0eoAxrpmwxJVT6bC8Cs9RVxvTYjgnXes2LdZm+siFiABOI57
 cL789pLQpNOreOHTZ59tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cBpOZU2EEXo=;lucGPMjLtKY73zLvodMSofaqQu4
 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

Hi Al,

On 4/6/26 22:28, Al Viro wrote:
> On Mon, Apr 06, 2026 at 09:07:33PM +0100, Al Viro wrote:
>> On Mon, Apr 06, 2026 at 09:52:16PM +0200, Helge Deller wrote:
>>> The debian buildd servers for the parisc architecture crash reproducea=
bly when
>>> building the webkit2gtk debian package, shortly after having shown the=
 warning
>>> below.
>>>
>>> This patch keeps the lock of the dentry up until when the dentry is gi=
ven back
>>> to the cache and after having freed the "external dentry name".
>>>
>>> I'm not sure if this patch is really correct, but it seems to have fix=
ed the
>>> problem, although more testing is needed.
>>
>> Hard NAK.  You are turning every place that grabs ->d_lock on a dentry =
scheduled
>> for freeing (like, say it, any RCU pathwalk trying to check if the end =
result can
>> be grabbed) into a UAF.
>>
>> Do you have a better localized reproducer?
>=20
> BTW, could you reproduce it on viro/vfs.git #work.dcache-busy-wait?  It'=
s possible
> that changes in there might accidentally fix that, and if they did it wo=
uld narrow
> the things down a lot.

Ok, will try.
Please note that building kernel/ installing / running dpkg build takes ho=
urs & days,
so it may take quite some time until I come back here....
 =20
> Some invariants that ought to hold:
> 	1) dentry_free() should never be called without DCACHE_DENTRY_KILLED
> 	2) DCACHE_DENTRY_KILLED should never be set on positive dentries
> 	3) DCACHE_DENTRY_KILLED | DCACHE_PAR_LOOKUP is only possible for
> dentries that had never been inserted into ->d_in_lookup_hash
> 	4) dentry with DCACHE_DENTRY_KILLED should never become positive
>=20
> Could you turn that
> 	WARN_ON(!hlist_unhashed(&dentry->d_alias));
> in whatever you'd been testing into
> 	if (WARN_ON(!hlist_unhashed(&dentry->d_alias)))
> 		printk(KERN_ERR "->d_inode =3D %p, ->d_flags =3D %x",
> 			dentry->d_inode, dentry->d_flags);
> and see what it shows?  That's a separate from #work.dcache-busy-wait te=
st -
> please, do that one on the tree where you'd seen the original bug.

Ok.

Thanks!
Helge
