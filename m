Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8B3033DA
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878613; cv=none; b=Ed5qS9OrmeUv1yNNfmHjWQemlQNB8eU0czxDWJptMDr3me/Dh/RJC+yF0C5qmWLx2It4RvXAmavWO5iFA5UANVSdATkZg8yOZLYjrXcnMfdoQaMrOmFG5gdKznuBaOCkeDMb1KYsuwdhzBWGKjuFGWHuD/MMrUQDrV564rX/kN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878613; c=relaxed/simple;
	bh=IeVWFNtZcgM9xf9pjZvYW5qFG+sA840BTb14ucuJjJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2XLZeq0PYoqJaQHozTlnmiu6u1LjhIwoRPF9J/I4WiDHQ3+p8Q9Q2oT13BUqNwN0gyi8WTP08rz3N+bl3WpMDB6xxPPFffy0OTy8oBqQoxtLUCMZQmzaU41ZjCNE3+d9av7ddnS79e4yMjazSCGOLZ0OmIregwJo4gTVZIamRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RmUN5XFb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RmUN5XFb"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9087fb771d3so2095556d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785878610; x=1786483410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yfP/6kO/mdLo3/KbGIYKYnGzsR8tUbD5DUupz4bpY6s=;
        b=RmUN5XFbff2urnUXBWSX8yA3lhcxSYJs0Y4Xz/ZTq25PRxULiYtJhdXhx8CndcNEkU
         /odOAqk87og3M3/qeqfmDL1Y6QJOnHE0g2dI73uX6u6mwl3tBo2znc2Cda+tSHueYXE/
         tfvCI6Tb39MQ5xp9QMydsqP4D5F3lI4w/jl9SlMpQ6kyVdd6aP+GWjq7niHIRt1rzcsw
         6p/eFS7Hz2vtEQ2r/Ae2KQjB5m+ixhbBQ4ut/IdDzpzu7wqvfLfO51ROS3ipxQsAibk0
         dToM5+PELd5tGiWQXNtRGkrjLOMOCafOUnlMHNib66Uegs6JiJOI0wEGu7nNpeUDFzal
         kE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878610; x=1786483410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yfP/6kO/mdLo3/KbGIYKYnGzsR8tUbD5DUupz4bpY6s=;
        b=eD8uKwruaxGecTua9uhj1i+T0gXrB0qOSuzYaPc25Or0ddgn8ugydLVkn4JtvevrhG
         fhl2+BhIZtT5dPSalxLzBPZzXpCKQNknbKV+YLvfxoJUZUbO2RqEsD2dQJmc1jeDIQFA
         ReUZp9D5QduF476e79II1UtLznaJObNscKaJJBki19L8tfC4i5csBZwEsBZpQED5A5fv
         6ZwMfAUeH6gkT/jjE7O5lLQy+IlCsSVztqCIVo2y6KejLdONeQgOHPFJuLDVehn4bG0o
         3U7QEcGrLh29BvJGLLEXTXQbAXn2iY22tlXdW11pklbc4rBjue2a9p15IXB1jRpbJqPC
         S/eA==
X-Forwarded-Encrypted: i=1; AHgh+Rrk5v3gZtr9ukWihQkDmEl+dPr5gmwtS6GILGm8v7zrQFBtgtiSygsKi/+fo5AfrI4Ss3cOMXswAjBobUWL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5k2mrhGp/jGDOuxwPM/xON7sXe6KYRVjsrfnUc0PhGYaurepk
	AdXK403wXMqkMvIDHsGFdsMU6bk4gTQSgXBCTuyEDk/NLyVK7d5paSuEIfZVGXj+H5E=
X-Gm-Gg: AR+sD13OmT4q95lPBfHQ1Sa3I65OOPtOsdOBdUVp2+Ps3FdftYPP/V/S5q9fYmtmTIr
	tdBDhq1E6Rzw/BmlXHKwVPdUTpc9+7J8lO82dVBpRQu9eJTUAiGq/+tbbb/8fJdu+UBqE/ZFHTz
	WBG2GlN0Lbv9HqrVdJKKsxeBgX3HU0NyZbSWuH2CMpjN75l6CvJskRGc3CViB00ahpD1SSRB/Y6
	hoAJCXpiBPoh2RdqPGzFd+xleiKnTxgiGsSZxWKbWIloSAdx84vgYJafsxVcCMXEhWix0HBZyXC
	sO41j6ZSpnfAKGqWSM4zjhFXgdJjZgk5KGAG93/FelIW87J++KR5lekrVnGo6/dS/4dpzNtswEH
	s3WRYQvmXlT2JvwqHAiS43vD1tJphkTCQfEgqLhfBPY/Oab9jDqajfCGe/7aqO4G2rlhygKBkyH
	ENdQP7nGCrR7SvsqINyZYvUvI1JgktV5yVgS/3YLOaJwygD7ud28lmfszgXShaU29itSm9GlGwv
	Goundvk24+Os84TqpYYfY3Pli3kVPPH8dj56SgZ/Ssb
X-Received: by 2002:a05:6214:e8b:b0:8ef:b049:7e35 with SMTP id 6a1803df08f44-908813c46a4mr27285526d6.31.1785878609934;
        Tue, 04 Aug 2026 14:23:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908800cabedsm10767526d6.46.2026.08.04.14.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:23:29 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:23:27 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 12/15] filemap: Remove checks in
 mapping_set_folio_order_range()
Message-ID: <anJYKOiKFoqLSTTo@gourry-fedora-PF4VCD3F>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-13-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731200802.574821-13-willy@infradead.org>

On Fri, Jul 31, 2026 at 09:07:57PM +0100, Matthew Wilcox (Oracle) wrote:
>   *
> + * hugetlb calls this with orders larger than MAX_PAGECACHE_ORDER.
> + * Normal filesystems should not do this.

Any static way to enforce this?

Otherwise

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
