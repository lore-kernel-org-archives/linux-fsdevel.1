Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EB93932D5;
	Sun, 11 Oct 2026 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750514; cv=none; b=iD7Jw8BiGiIJIO01evG+8hPYURbIsV/5jHzCILCY/rfRTzwFMtfuK7K7+GXtqMrVWR1OOP5Uf2r85vHhq8UKItuXZX2I/BFLdXw52MZJAEiiqVt68C5Qq5LPQ7hd5tds4t3GECyy8IwW7CzNvMh01l30yIe6DdE4wTNsMitIKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750514; c=relaxed/simple;
	bh=cXC1/d/7Pq2ANFf2momWoz1YJa7rgM8I2w07ldzx/8E=;
	h=Date:From:To:Subject:Content-Type:Cc:References:In-Reply-To:
	 Message-Id; b=Nf6ixRGm9yZ0J3SmLaiGsCjkzuuCizuOa1LKABvs3Vg1L1U888lvwhuN8Ebc2wVYLVS8xVxoB27cpNdmkV78wMpH5OLiZH+g1SPrggXwqoiJtTn0PTuj53eU6p2tbJzXrMgd84e5wJ6H/gkU84rgpYY0uqRPD+sOQEX8D7V6PXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=scdbackup@gmx.net header.b=WGtHaeMz; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=scdbackup@gmx.net header.b="WGtHaeMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1791750508; x=1792355308; i=scdbackup@gmx.net;
	bh=/I6OequC5xynLWfPbbK5h5SS0Qss8b5GvB3Trir68xs=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Content-Type:
	 Content-Transfer-Encoding:Cc:References:In-Reply-To:Message-Id:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WGtHaeMzyYLw9ZOQ0cV9JlaZ7nQd5CYiI1yFcJNQuu2lIdZDjP4No92VEkPFjKs7
	 9+fb+HcvzWgFbKxMrFb6yMZVukfX4xnGNNPJFOZe12n6w8XCxVxreiI9xz18cW6Jw
	 fNw/DTBmfk9W4YeGqzqj4oovoitSBwTGFLo1upGRXM2WI1aww2GTcyqfax3IiC8R9
	 BoFlI6JiB/VkvigQ6nUZvsTGIngUmU2w0LlnqHRjtfXNUF4SWfP0+9WNVRDcfWnm0
	 rDp7PwuxxGrpGJ03solkYL68K79Dw7lDtuBkRinJEXuiB/x9T92jUIGx3u+uW9xMV
	 u0RHy/QvFNmspdslSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1wlKVY3d0J-00pAhO; Sun, 11
 Oct 2026 22:28:28 +0200
Date: Sun, 11 Oct 2026 22:29:07 +0200
From: "Thomas Schmitt" <scdbackup@gmx.net>
To: hengyul@cs.unc.edu
Subject: Re: [PATCH] isofs: Fix handling of directories with small logical blocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: jack@suse.cz,brauner@kernel.org,matthias.goergens@gmail.com,linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org
References: <20261010175649.700233-1-hengyul@cs.unc.edu>
In-Reply-To: <20261010175649.700233-1-hengyul@cs.unc.edu>
Message-Id: <13464510581423749223@scdbackup.webframe.org>
X-Provags-ID: V03:K1:HbAe8pvvmwdtBvYoKaA9X5+jPx/rMhOOX2awvVgXesFHhfvY+Ny
 tc32AImmLPOqXlGVx8lC7m5gB2rsvWP4Y9OYF4kYBI897CMD4kp/wZsyveVAibImQDv9G6N
 FV93cZjBPkBRT3dppCOWrPZy3MFBSccp+rp3W483YN8/1b8715ZbGlTbFDD/eq+DxOFhSpG
 mqvWBktDWp/vxCnqPraSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:60idN//JQIQ=;pdAfgEFE3uCwVRol7/+xKyfFd8u
 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
 +ErRSVA4TN4y+UZFOiVrlBDmBPPm7lSDqTXDQQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Hi,

Hengyu Liang wrote:
>     mount -t iso9660 -o loop,ro lbs1024.iso /mnt

Do i get it right that lbs1024.iso contains in the Primary Volume
Descriptor at BP 129 to 132 "Logical Block Size" the value 1024
instead of 2048 ?
(Where could i get such an ISO image ? And how was it created ?)

If so:
I agree with Hengyu Liang's assessment of ECMA-119 in regard to
Logical Sector (device-related unit inspired by CD sectors) and
Logical Block (filesystem addressing unit).
Assuming that my understanding of the isofs code is correct, i am
astonished and impressed to see in isofs support for
Logical Block < Logical Sector.


But i see a possible exotic consistency problem:

The mount option block={512|1024|2048} may set the address unit for
reading the volume descriptors in isofs_fill_super():
         opt->blocksize = sb_min_blocksize(s, opt->blocksize);
This means that if it gets through, it is the assumed Logical Sector
size.
Later the block size unit gets overridden by the logical block size
which was read from the chosen volume descriptor:
         if (!sb_set_blocksize(s, orig_zonesize))

The problem would be that during the check for allowed crossing of
logical blocks the Logical Sector size is hardcoded as ISOFS_BLOCK_SIZE
i.e. 2048.
So if the user is allowed to set an initial Sector size, shouldn't this
be used for the check in this patch, too ?

On the other hand, the default of opt->blocksize is 1024, which
obviously does not get into effect, even with 512-byte-per-block
USB sticks.
So can mount option block={512|1024|2048} still have an effect at all ?


Have a nice day :)

Thomas

