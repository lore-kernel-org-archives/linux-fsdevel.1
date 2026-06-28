Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2B15746F;
	Sun, 28 Jun 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782678435; cv=none; b=L5n9BWEy+vgkQBCI7YAjL6YvlKSX9fDyNimq6fJZylBiTBPdZ5VSj8giv4w677qPKwhEDzYuJT4cLHqL2vS0eVKnO0kGF1WJ0Q76KDvVmN4BxR8fag5lO5m958OrDJ5znCtrdoeCej7xE7Lv0glKcA+voS1SLtgMHMrHC+Y/u38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782678435; c=relaxed/simple;
	bh=YuTKTXvOQ4Snj53hyytrDJXHs9FTo1Rp+Mas/VmbhNE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MZ0G3RihBaN5pkMP9T3tvjKA9P6D5NkzUPAm3DKlYV7FJ96NsNGNSVI5P9fNmr+t/IXJNQh7Qgg4EOWCZn35u58CdOABut5DMpFotXIL+00PDMMXAhReiq0xlyRGPms9bdrp/9hrAx8bClRmb+WbNObXcCuoFWEJgwFYGaJnpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=v6C4cClQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="v6C4cClQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B690F1F000E9;
	Sun, 28 Jun 2026 20:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782678433;
	bh=FhFoVC8810KaabKMCovs2FDta87wHAC5bgNUf9csy2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=v6C4cClQdkVml+MWpzf/NXo1K261SCJ9Gc3wmmbhYJ05K2ve+Q7QtBhJkmwhLTdgz
	 VyzExj7g3Fq3Tc18yzHnbFfe77stBCtKbk2sDI9W7TwMMUiAWplcUjXXAVYqrKDp7P
	 /b6LZB2obRqM/zCOQoiCcW5UM2vnmeBx80wWBJf0=
Date: Sun, 28 Jun 2026 13:27:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-kernel@vger.kernel.org, OGAWA Hirofumi
 <hirofumi@mail.parknet.co.jp>, Yuan Tan <yuantan098@gmail.com>, Yifan Wu
 <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>, Xin Liu
 <bird@lzu.edu.cn>, Yemu Lu <prcups@krgm.moe>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/1] fat: restore original value when fat_ent_write
 failed
Message-Id: <20260628132710.61ba480f961e8b87f02f80a2@linux-foundation.org>
In-Reply-To: <20260525085649.781643-1-n05ec@lzu.edu.cn>
References: <20260525085649.781643-1-n05ec@lzu.edu.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 16:56:49 +0800 Ren Wei <n05ec@lzu.edu.cn> wrote:

> From: Yemu Lu <prcups@krgm.moe>
> 
> fat_ent_write() may have committed the new link to the primary FAT
> but then failed on the mirror copy, leaving the chain pointing to
> new_dclus even though the caller will free it. Restore the original
> value to keep the chain consistent.

Thanks.

When fixing bugs, please be careful to describe the userspace-visible
effects of that bug.  Here I'm assuming "dereferences freed pointer,
kernel crashes"?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@kernel.org

