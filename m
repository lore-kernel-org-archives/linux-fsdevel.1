Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC730E0F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939080; cv=none; b=pH4RTKSqLqtAiO5X8XQD2CaRiqi+9V/NNyDVHMYos9qEuavwXQ0oYuUod+vtcf9CNHGG/cXfmNswTWTtkvD3AZwB/LDZVhacGjKuK1W9oQaatsOljZ2WLobwcclX46W4jezncp+jHvIrOWvWGs/HrdIMcjsiIkbLlGG5wBSJo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939080; c=relaxed/simple;
	bh=HT46huxqYLzd/hL0rjYToHH5MEf0eGRmY8ySXOIaHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8LfSDWUINpiXk2RZ+hfUbd9PzinK5x6BL/C2zgPNdPEWZ6KJoSCcWry4e12D5rI3YEln6msOl1QB630TkjiYd7avl7mdtQ7j6fNNTjVK5eAW2ofPvkGOfavFhgItGkYYO0eClmxQNkPOqRfsl7kWqAJVQ8WdITFBXzCp/n9aOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD95868B05; Tue, 31 Mar 2026 08:37:55 +0200 (CEST)
Date: Tue, 31 Mar 2026 08:37:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
	yuezhang.mo@sony.com, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
	chizhiling@163.com
Subject: Re: [PATCH 3/5] exfat: add iomap buffered I/O support
Message-ID: <20260331063755.GB2061@lst.de>
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-4-linkinjeon@kernel.org> <20260330063821.GC5897@lst.de> <CAKYAXd9pZx1g=53wtCh0xTVYgQCLNz1sEL-2-fHbkSHQ=qTiTg@mail.gmail.com> <20260331054616.GA31506@lst.de> <CAKYAXd-2=AM4vdwB6wzycDAXQd5CJEqUU0GPjRvskqZYFXS2eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd-2=AM4vdwB6wzycDAXQd5CJEqUU0GPjRvskqZYFXS2eA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 31, 2026 at 03:36:35PM +0900, Namjae Jeon wrote:
> Since Jan's series renames __generic_file_fsync() to
> simple_fsync_noflush(), switching to generic_buffers_fsync_noflush()
> now would cause a conflict with his patchset. I think that we can wait
> for Jan’s series to be merged first. So I will drop the
> exfat_file_fsync changes in the exfat iomap patchset.

Or just open code it in exfat for now and switch beack to the generic
one once that becomes suitable again.  But we're pretty late for the
7.1 merge window anyway, so maybe not rushing this might be a better
idea.

