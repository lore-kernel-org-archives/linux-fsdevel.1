Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F72F8BF0
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777238895; cv=none; b=LsgLv7t/6il9qO1gw6mFw43ZRxzr1kJ2ORmjQ+e/wBxdPrGA98bEC1JIwRzRNO3yCh3pnb+nBNAFlUN7Yk6VVnNSr3H/G6M8IlEQsjz+d8+jdA25WZMdBiZeSWxCIiQhc2SMlE9VKk9QCx7JhOg61HT0m1AoyZkE/12ReVukp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777238895; c=relaxed/simple;
	bh=/avPC3bEQsKT6TxAZf9ekEriJSICHatwfDGpxOPwXj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rK0uvxUB7kfIWnUMN8VwyiUNoERgU5Ps/cNX5HyR9sg7c9OyiRXLiUkQR4yyMSNq8rdcWOUjD5eyDq6TZj02pBKbkuRUzoS1Ewo+O8qHWKc33uJQ7ehjfPUnU2feRc6eTzrjgQEuX8ZqMyjsso+C9rgEZQS/uTlBLGh+6UrBCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=gnom8Hh0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OiVmc0x/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="gnom8Hh0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OiVmc0x/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 620A11400027;
	Sun, 26 Apr 2026 17:28:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Apr 2026 17:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777238893;
	 x=1777325293; bh=ch2r00MgjYtuT/zhU+l8R/mOvWT2LsdN077XGhCbbJ4=; b=
	gnom8Hh0wsQToUk0qHC83bSpOUJ+WYPi21bjLd7tU5FBk06cXlypJTzh2CJvJx4C
	Yw4uWawkM9bsP+zHjT8FCxVstTFNw0AWnrXGid8o9Y8ChnFYEN0LvZJdo+46x6CN
	ng5mxS4wWRsL94kHHDcDCPt2I9BJz/IaYfsSuSiY1a2gJeB5mSeQCkh/3jXBPp+0
	OeLpafjFD/tl+b0iTyCBQcqsDfyskYWEZpIsJTeoIWVdU8LviPNZJIKLJ41Neszz
	xchIpJd+UMG9/tV8PBwmAdYdcdnIvNUOzBfSguQwExjDtoOPKyJXxmzBUF+vJEZA
	oapDM9y+NollSNhJft+yuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777238893; x=
	1777325293; bh=ch2r00MgjYtuT/zhU+l8R/mOvWT2LsdN077XGhCbbJ4=; b=O
	iVmc0x/SLKBNf8/jEokBdBePk2gWuy/8V66yQkinpWyk9lgimeD6sXYg8HbqdNxh
	aTNZ9IZKXYiBG7fcFRmtbD93d+AKN8umKO7IsGsAL/VbekbwvlDITYMqK0445Qrw
	wmTa7s7RC3dc4Thy6sUHRzJ0AQv+c8/V4IRdpEd2ZGvMlkTUZfdPIycrpkPBtVXZ
	TP+bK0ecGzk2GrPrE+x05UMhGhYl6SDsNj1mBwFq+C9YCMyfT3B8pr6MQbmYDLdr
	+IHJ0uUDRQ2kCKO2VYvVeDVxtBnDDBfvZaGf1jSwKbUFz0jYJfqv94Erx1yue5lh
	+Ntpo7IbSTR5x96Txbz1g==
X-ME-Sender: <xms:bYPuaU2gMxzQlWztJ3IxYvEX8FgVabbkUvXGaPOS9741F7TJqT8yIQ>
    <xme:bYPuaYbe6dTPzi06QNzIyWqXx_PK9Sn8tXh4bqRiM6HNS-vqO1BtbSa7OVl34qraN
    iUw9bzLpZa5dN3Kl6LZYAEN8hSUaOSubSGtKSz3zAXwZvuhJzwL>
X-ME-Received: <xmr:bYPuaULyfYOZT_uwHx7UZrgAYK9osCgMvjR0JBSjHIRzT6RWwP7hTNOQCSPDldj0kH1-IikffWs6fxTDjnQPyyBepJ-3qERbysiutbakUhlSG3ZpNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejieekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepjefgieelkeehteffudeitdelleeilefffeduheejfefghffhvedvtdfhhfeh
    iefgnecuffhomhgrihhnpehsohgtkhgvthdrihhnnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfi
    honhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggrlhesghhomhhprgdruggv
    vhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehfuhhsvg
    dquggvvhgvlheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:bYPuafGQT0TuDtwUAFpAR4VAje-kZ3TlTZqNzS37f0dzxGhXaQCDsA>
    <xmx:bYPuaTuzTTx-jJCrBBMzlViH5kBcNAVx_wDq9yG9nt61ULaCn74t2A>
    <xmx:bYPuaWtWTt_eioNVQrLvmxz9qE9wUo33WIPlMuNR58MwUGCEvfSszw>
    <xmx:bYPuaZDJ5tXEu1VNwD-ctfLabY86xrvU-WwLisoBzL_H4L7-J4mgKg>
    <xmx:bYPuabFz2MWQSs0e_iCV-H2YvD25w8rhAFleH_vCwQe49d3kg8OJmuQN>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 17:28:12 -0400 (EDT)
Message-ID: <18844024-34a4-4e72-831f-04effc8e1418@bsbernd.com>
Date: Sun, 26 Apr 2026 23:28:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] example/service_ll: create a sample systemd service
 fuse server
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
 miklos@szeredi.hu, fuse-devel@lists.linux.dev
References: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
 <177689988738.3820166.3563042250723069297.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <177689988738.3820166.3563042250723069297.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/26 01:22, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a simple fuse server that can be run as a systemd service.
> I plan to create some more single-file fuse server examples, so most of
> the boilerplate code goes in a separate file.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  example/single_file.h        |  153 +++++++++
>  lib/util.h                   |   35 ++
>  example/meson.build          |   14 +
>  example/service_ll.c         |  312 ++++++++++++++++++
>  example/service_ll.socket.in |   15 +
>  example/service_ll@.service  |  102 ++++++
>  example/single_file.c        |  733 ++++++++++++++++++++++++++++++++++++++++++
>  meson.build                  |    1 
>  8 files changed, 1365 insertions(+)
>  create mode 100644 example/single_file.h
>  create mode 100644 example/service_ll.c
>  create mode 100644 example/service_ll.socket.in
>  create mode 100644 example/service_ll@.service
>  create mode 100644 example/single_file.c
> 
> 
> diff --git a/example/single_file.h b/example/single_file.h
> new file mode 100644
> index 00000000000000..d8a91adbf875ef
> --- /dev/null
> +++ b/example/single_file.h
> @@ -0,0 +1,153 @@
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2026 Oracle.
> + *
> + * This program can be distributed under the terms of the GNU GPLv2.
> + * See the file GPL2.txt.
> + */
> +#ifndef FUSE_SINGLE_FILE_H_
> +#define FUSE_SINGLE_FILE_H_

From the name it is kind of impossible to figure out what it is for -
requires to go through the code. Could you add something like

This is not a standalone file system, but a helper for other file
systems to expose a single file backed by a physical file or block device.

For both the .h and .c file? Please feel free to make it more verbose.


Thanks,
Bernd
