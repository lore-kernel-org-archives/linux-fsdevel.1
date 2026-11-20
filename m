Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199508;
	b=JVQ3j9njLcD6dEk7GgcTgBs3ojlBqmKFGEaVMGadejvjtA97XnGRj8bk+kStObcPseLQ
	 2S1bNjxXhtSkQOeFM1hupZl9w0ADPmo5DmM1j0T4q1YLhu6LQusb1afuUg2P4ZmD01Zuy
	 r0JPAcN5prydZOlbAJ8aQ7GzVL8p4FSfgjRP+Bn+/BQ8FxNdePTeAuyVCZNYi+uj0sRVH
	 YpCgKB5BxTnGirI8c+r+8yT7Ip+/jgVVj8RgVlsNjpacpOnOW38zxZE2+GMlM3ZTj6j2r
	 YUJZUS57nVrjY4xS68u3hNYAxw8OXXy0Ya0wT5xuzV03n7CGjN//DGCEVuvzFadHvSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199508;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=qYJcWfTYpnC74yUaIMEVR0tCkz3lShOSI0xSlCRIQVg=;
	b=nmzYwlPDe0Sm0YwzfLM2i9eFJ53SyW7a7eYXJQxo9+dvLWNI5EVpnyRvdHo5XsUayi0Y
	 Pd1JPB5eHvBTjmFqnu7IKA53afYhGhP2lSizaM8LSNjExsY1eZiJMpgPneHBpnYQAQY+f
	 9N9ItEeFVKQwRRdGttbBQ1zgNaVxa8IBrxiUEDmjNaVo/Z94C2r4YTJzDwZD/k+HA62V8
	 XMmvClkWc2jdvko6oUmjBd1poresrtP/wj6jRugVPfEMhOG62VCXJ0yHrqXCFO7c1vo7/
	 Nu1Jdvg5yD5ZX248Cg+Ufpcy3KJXOCA7aEGwXu7EheKKarioaLMgYSus9Ax0htsOIoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E9606A330;
	Fri, 20 Nov 2026 18:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F4E9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E84EA68AFE; Fri, 20 Nov 2026 19:31:42 +0100 (CET)
Date: Fri, 20 Nov 2026 19:31:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/8] fat: drop ->write_begin() and ->write_end()
 usage from fat_cont_expand()
Message-ID: <20261120183142.GB2339@lst.de>
References: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br> <20261118020150.1023865-6-matheus.aalmeida@inf.ufrgs.br>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118020150.1023865-6-matheus.aalmeida@inf.ufrgs.br>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 17, 2026 at 11:01:45PM -0300, Matheus Alves de Almeida wrote:
> +	while (pos < new_size) {
> +		index = pos >> PAGE_SHIFT;
> +
> +		folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_CREAT,
> +					    mapping_gfp_mask(mapping));

This code would benefit a lot from moving the per-folio logic into
a helper.  And given that all of the code until marking the folio dirty
is entirely generic, can we have it in common code?  Did this get copied
from somewhere else or are there other obvious users that can share the
code?

