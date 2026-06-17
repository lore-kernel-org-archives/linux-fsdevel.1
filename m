Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91217D6
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697113; cv=none; b=R2BFF3lJghWvvwJ0z9Knac+IOjHYAtUzFrXX+/MX8KySXm3KzSrXRE37SxFpK2zh454kzrGuruMCrPqSb6Y/1gyfM9gvGl17yGpeQ13vw3Bkt4j/nvO8EfzVJoFKzARM4RB/NNBVu7GVYq0RHwhXOLlEIT1dhBedg96QtPG/HoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697113; c=relaxed/simple;
	bh=K3Vfon7Ki8TNrVNRfvLQgsdn3/RQE7YLfU8eGcmZglU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egiGnKbPGE4vj1jk79Eh1e6jtSdbT/SZPvBCI/EaSCxHQHW0i3/0989zMJY88yZ+U88podlWusg+X4r0NV7oILHv22VI2ne/OmUcvTVCiDKuEnRrI/vDpJ/qn1jv6EKyAVaNjeXNE6AHIShabwD1+Io0qItBv3y4IwGdF4u8Obg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf1B+y26; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf1B+y26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291671F000E9;
	Wed, 17 Jun 2026 11:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697112;
	bh=tYZSspCnlcWtdxovtmqEqCygbTvVVNxg9U8mlLNO2SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mf1B+y26Q9JqpDF/hmHwuD9HbGOkMow/sPiNIhiX5BkTZuiiSLXD4FkVJAFB3wcwA
	 R930hfvxFdRJ0tMy5fYID8TMf1S7iCQot/3MzO+D4BnQjZJwH3Xxppxy6J4F2WlBkj
	 R5G7loMhX6b7YclN5f1OcgRo6ClsYab10/Vwh840FNQefrcq7Jbb4cXPnhA1jQntr4
	 Veu7vvq/aoTC928cDuj8WTBcE9VborZkvtsKOxCkJJgZGibvcU/Zvi+KpKrpQLJo2n
	 U7q8fdUXbQ87eoE/iTIvZ8fwk6euuoGefUt55aCGMEzj8jxAWi1lccX3yHCKDZtnv1
	 wRvQzYkAZmeVQ==
Date: Wed, 17 Jun 2026 13:51:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/8] fs/configfs: switch to get_tree_keyed()
Message-ID: <20260617-unsanft-vorurteil-neigt-8a4e50cd677c@brauner>
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-8-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613111437.101763-8-hare@kernel.org>

On Sat, Jun 13, 2026 at 01:14:36PM +0200, Hannes Reinecke wrote:
> Switch to get_tree_keyed() to instatiate a new superblock whenever
> the mount namespace changed.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---

So I wonder what keying superblock creation to the mount namespace
really gets you. Imho keying the superblock by namespace only makes
sense if the whole filesystem is tied to a namespace. For example, the
mqueue filesystem is semantically tied to ipc namespaces so tying the
creation of a new mqueue superblock to the ipc namespace makes sense.

But configs isn't semantically tied to the mount namespace at all. It
encompasses a bunch of different subsystems that might themselves be
semantically tied to different namespaces. The specific example you care
about is nvme tied to network namespaces. But there might be other
things that tie to other namespaces.

So even if you tie it to the mount namespace you presumably still need
to filter what subsystems a specific configfs instance will display to
each accessing task based on the namespaces of the accessing task?
