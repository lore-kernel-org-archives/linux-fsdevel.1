Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC916EEBB
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207712; cv=none; b=DIryj9woMPGgX3LHXpGEBEw0hU617EwzgrMWrv3336TrGZuwBJNYSahM/XCXR7Z9N/N0OCT92aner0ur+kThxAQTUY97w8bEs5QzJBBnUAgtnkHFlhhFFTbYwPf23Hq3xsH7XFtICmTT7nKgzZx0remB+Et7QA5HoHWyHquiqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207712; c=relaxed/simple;
	bh=yKPD8uyURJXe0BzinvoVBVjRb0gOiXVjxJMyIu+ssNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWi1Jx4K6ubLjAJOG/o9qoHpZxqabIP6haeKnCGlZN8BBlIajQoG/AM7uEL7DDf43RYnYqk2tgHnCfjKfLVgZtkingfVwV010zaKEZRTsqVb4rIpgHxva1I3yE0uXPHFpUDYkNcAHELi7wB+06yzZFcpLeBNPR8e0QhyybglkV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kPOZDFr5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kPOZDFr5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9305a2121a1so285267085a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 20:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785207709; x=1785812509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4Pummo+n71rvpjOibaLf+dE0Duq0sHkDOk4xh1L+FM=;
        b=kPOZDFr5CNiYjZz/FiMgvibf2FGP214is9YqNQI1oxbVsPnDalPOWUYsR3XnoZwDCh
         LwtfDmQexemP2+KD7L9J1bPgTxj6xhu6ECT0XkG8fCiFjqjsOpOtnVn1LDgPSdI+DqSI
         4tbYytoepwrohGwTrRG+AlaW7YfoUWFAmARvaycxS9lvzbOVe485/CnSpGuzf1yzfQeN
         lob6bmdNMYr5RNVal/lRIHRKrETjgr+1NfyIUXw52gDKV/4cHyJnmMLveUlH7Zb+97WC
         XMqeYthvaN+7kPoveH4adGw5vFHVEwQiQ12RdiAyHPhak1yeFBi7ayJLUjYetxO/JjD9
         8/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785207709; x=1785812509;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4Pummo+n71rvpjOibaLf+dE0Duq0sHkDOk4xh1L+FM=;
        b=JP3gxp2L+sH5WvBEgbZv5zHxbTxy823JOUyh3StXb7db/o71vNVizH3dtC5MqJflFm
         Y58XvjCnPrJ4n5/OiI6Rjyao+Nt3sfwNfM0vQQgiva9XmzVYJE1LG48bvy6NdRZGAe51
         DyMHvj8UIyZU4O9RBTN+dnzPSLV8r9gtocHqFJrJCjrz0mGGJqrWcNuGZS0i1dogeqJO
         xlEUAgi1reZ52zt8+KHDIbo0KzG43S8dkApw7UGYS75o1kjjjlt1XtwmOtIDnG7jcPqE
         6UPACg0JRAzZ+J4aJ2TRxoxng0LNJOyuV7rOCGMTLhXebCkgkFRf20IzH35meldKecFT
         VGIw==
X-Forwarded-Encrypted: i=1; AHgh+RpcpQC/7OESXKCjed2lIWmKFXtzOabnvjMwFlAfIR2v+FpHeEskkcMb9JvxSs0P4emrAvHI+QZqvnnQVK3f@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvZFUjnqNes5Yyl6aFjCo/4tpfl13Zq/Zub+7txrMHItJaTu7
	e+vHfTqa1SDJBrjBk3hA9hu0Fa/c/gFS1DWrW1/lytLz+euLp3v0C1N/uiFr/rP4XK8=
X-Gm-Gg: AR+sD10NgedrBM05Hl/xrzU3Ui+Jq48blCTzYjtH6GWBFKCr+DL5XUoz9BTFp9jjGSL
	fUH1zVz0HlfUARjsUUTQevCt18eIWGIfWFC1GK959iv1QUHlaDahlLsT2zmMdasahddpxmgJHew
	i6z7UJ+MWbYzs8hMwgaGkWgfj5KBZ1g1/IOmgX8hWrApgNmdNOGqErDs9jMLh03vXNA6TtzPoJu
	lAWDVviDDlj0ri5EAIQ9AktQdbAtQl3YkwgT8xnXTGlXk+y4FUfZDHOYJyu5PJ6C7dPtBshEFpi
	LA7h6WIhnKkTWDV2xwtCkBh0G6hhfhlWrf9c9YHDPgNQigLMgoqDp8dGjCMO8hAnmULZ9FEwNq5
	6RD5XwC5C8Ly9bfdGzBLCRoVV1kHPAKqx9PWhpgXzqIAOoAMZk0qr5zzUPhNQTRDBcigtQNinTX
	fczP0fHhlAAyXVYaMwtFo95dmLrviJ5wFoxU5PdolpFr03up7+ogftr1SdhA==
X-Received: by 2002:a05:620a:45a5:b0:92e:78cd:13f with SMTP id af79cd13be357-93302659657mr50219385a.33.1785207709426;
        Mon, 27 Jul 2026 20:01:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de53f36csm753319885a.11.2026.07.27.20.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:01:48 -0700 (PDT)
Date: Mon, 27 Jul 2026 23:01:43 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>, 
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH v6 02/12] mm: Rename folio_contain_hwpoison_page() to
 folio_has_hwpoison_page()
Message-ID: <amgbhnH2JJqnCQu-@gourry-fedora-PF4VCD3F>
References: <20260727181310.2671972-1-willy@infradead.org>
 <20260727181310.2671972-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181310.2671972-3-willy@infradead.org>

On Mon, Jul 27, 2026 at 07:12:58PM +0100, Matthew Wilcox (Oracle) wrote:
> This is a better name for this predicate.  Also make the argument const
> to allow other callers to be made const.  No functional change.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Gregory Price <gourry@gourry.net>

