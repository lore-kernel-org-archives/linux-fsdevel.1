Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EAC3B058A
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393185; cv=none; b=C4I7RGRn85mF76+QSL9+Rb81CfbM6+Dzg9+yRYyyFIJYa3pFye06at8iX+lxbnP5mVLXToPIH7PqIc8fnphBOtLp2OiQsk0Qom70lev7mU80+9kk+Rzezk+11hWei3Wnb1LnsvN0p4dln5uYcP8h9k8Xrg3H+2W1lHxTyFMjjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393185; c=relaxed/simple;
	bh=mE0FCmxFAcg8+2FAt8rKZAFyLmmxB6bNkFOqEWN8ZzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy2qxlpanEXWW8diRb1cHppW/PnxUiSFDf/5O4PZUpeYwx/vkAmSWcCG6aozVybSV4ZutLfhm7CwExG0l2uApRMqt5bOuVa3q5fHUc9tYGb0A3uJ1NOUz8z30vGZ2w0CgAQM0Y9pzpxkBk/LWlLEZis/ZlwXNx+LCnMAuw0XRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jJU9QT8y; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jJU9QT8y"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so3061566d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 23:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785393183; x=1785997983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bSQdFbtMw22wegisDIIs9GXGwF8lm4tP2s7WAQxucNU=;
        b=jJU9QT8yJtCAp65+9EuO3Geo3Vhl1afACkQb/QTuW4PGYHwwpsdgJEMFkuDag/6kk7
         m7LGrtoq9CWm0jj+oNAAnFIJ+1uA1OuB4R38o8IGEQRB8D4Bc5OoG87rt7KBedmO54Q8
         /ITFQjtFaTt/hyWdZH2vHU5Flo/tI+o4EDNXU+g0lI2BWO17OKpWMtBSZxFFxYOOb7Ei
         7UeJW4ljRCF4HQ6VSnXxTaUs5lZq4ai1qnnTtYd7kN9ehYyQjgbL/AeDDO592uBoRXYy
         Jsk3GaqMFEtSsfWznYZs/1Xv13b8+Cm3s/EkNXi7G3oe2tes9DXNWV7zCrT9T6cPFpRh
         ep1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393183; x=1785997983;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bSQdFbtMw22wegisDIIs9GXGwF8lm4tP2s7WAQxucNU=;
        b=STD92Q8xvdujFr37TxI112iGD41n9K1oSMwhb05wN0+NXYHfYPTPWs+XD+PHi1X4fV
         hOlvWGey4k+fWh2mPLKDT8aEd0VdAopAC3X4lSCxsOE9xQ188Qt+0/b8CvkMetQE0qMh
         aBLcUUnfJ4yIEbTUAuLOjHGoVeAYRqIfwm26i9xVsu7zMIl2ccPtixzjIKfPb3ixJuDT
         zNd8zNIVIk0HXmyxNOyb/b1pW/m2uLp/cmhDk/uUf/MX5nQh1Z6Q+s3SOFrAvkDGyb9l
         1lMEpLzOPoYKHgiGSz87QRa97eGLnyzFPih9RnuknWRBiJJ8wmO5OttyDoeshf+GDYwl
         /VMg==
X-Forwarded-Encrypted: i=1; AHgh+RpqSL5UMHyqi0MvtrBe5qeJhF5ZqpnelKGKQoRZR844GYqRR1rP4LUSrYzKdcNf7sMe4C+4DiNyIbCngjcS@vger.kernel.org
X-Gm-Message-State: AOJu0YzraqSmbn20OEUxEJp0eqCLVOoDw5W/8THvUYet+6ATa82GSoZy
	7BblvuDKP89FBeH5aN71MsTQ9Bl4yLtPIBEfMYXCkNsx8uziq+jXe2QFql2NaWH+SII=
X-Gm-Gg: AR+sD10oJGXjmqVb16FlWwTONeXaK9AJM+lF9VQODhsngFzRRiFSSdDrl3KJqsMqmON
	I1COV9fO+Mefz91olceVZqJkTTfFam3M0gpscM8LBacxgrGaol8hbidMAUTtmSjBJCIsZElCe7N
	bsGRwJ+U2VRv3oQFQDcMHsrDDHN4WtN3XduY0II+E2qrMQrZ+DBBtm6QLchQUYdE6rWkM/mXQUU
	wJBTe8XJDivbBC9a9TxIFCzpVpY3gYHkHLDJ40MdQYoXj8ZmY6Bu9aYb7CKCoDkSfC16Vpos7CN
	p/eA5y6pnXjwbdscQXEVVTcnfRCa3/igpQVQkkLez5Jt5KTCarwCTS97HQQdj9OSX+NZE1MTnxe
	gHywjY/RdD6WA7t7KUWBgjFuSvFl+YlXjhieSp1PXv+TqNgymaiLlETRjUICRM8jFdOqafQqOun
	L5TS1+a2dnD0CXhtH7f8Vy7UJoeQUvHvB04G6JZ2xggXdeqNlYMGHD96xFCggk9nhMxhaQOBZ0w
	UPy9IY+oEkTo2iWBl9XsivAMn90eNrJUrT/dk2Hej4JmV1N5IuVLmA=
X-Received: by 2002:a05:6214:4b03:b0:907:8960:fb59 with SMTP id 6a1803df08f44-908351168b4mr10279196d6.34.1785393182683;
        Wed, 29 Jul 2026 23:33:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323e7697sm10555086d6.25.2026.07.29.23.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:33:01 -0700 (PDT)
Date: Thu, 30 Jul 2026 02:32:59 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 04/15] mm: update print_bad_page_map() to show
 anonymous page index
Message-ID: <amrvgjPNfKqWPUU0@gourry-fedora-PF4VCD3F>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-4-e8ecfefea812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-b4-scalable-cow-virt-pgoff-v3-4-e8ecfefea812@kernel.org>

On Wed, Jul 29, 2026 at 05:48:39PM +0100, Lorenzo Stoakes (ARM) wrote:
> This is potentially useful debugging information and matches the existing
> page offset provided.
> 
> Use the raw __linear_anon_page_index() function so as to always output this
> value regardless of whether the mapping is file-backed or not.
> 

Begs the question whether we should mark the value based on whether
it is file backed or not, but i suppose you can gleen that from the
other printed values (anon_mem, mapping, vm_ops, etc).

> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

