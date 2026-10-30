Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362384;
	b=ySWfuNLyEk9WKqPe+CpFAKEPrYmk1SJWNaC9InsxxN3vpL4GZhbFn/FEFCXRrbZsLZv1
	 RhCOqKMRW3kL+dKHol/RDsWcjhInV60B5szsml3gkmLUP0PWihYERjMANn5GEPZK6C/om
	 HKLZ8wBOvRmszodinDq4HZXqKM255ffDbhmX+TxLUdOLQCoegJj0zBp0ZApPzKREsJorb
	 zpmqv5DlFO16mg8eTRXOWwz6j6TV9e2zEeAE4wuk9B9SABFbWiBLwyl6P8ShQS1IL8WkM
	 DVnu10fyOCNGzWsW9yhi8nazm4vqPLWmtQFOwpH9W8CYTOmreHS/qNo8B5HQ0kaYP8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bZKAADSfZoWv8xOE7quCSCjhwlCNy+kog5o59siXEHg=;
	b=qqed+dN/teCttU28xNQIjwfz1FRO8lur1LY+3/b7fwidK8RRV47iIL2ZedmYGXrBeO5e
	 XQNh6zSj7jbxlqvsUiSi0g1hLbjLR5g3kuyf+2XXVOB6sxh4TIi3qQDexKVZpUcaHJo+F
	 Uooqtnk73YIFf0iNuGoGTa2ywPqWMpVp2yvo4qdQtwB1iaBYpoSXLFCAUZCGiBA9f5yBm
	 y/VtD6OBRyDDiyBTtJG2n/8L8sdK9AP2Rcdks/jGUtBPZv63FQ27T0ODyufV/eaGX9kS/
	 hi15M8kaHs1yZUCHdRpjcGmZZt+/iI+nApoiRa9AuXBIuQbh0Qo1Dhc5okBD3vzDiEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=D9IrWoMl;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC0606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 12:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71FC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=D9IrWoMl
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c79a9a739so10416766d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793362383; x=1793967183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZKAADSfZoWv8xOE7quCSCjhwlCNy+kog5o59siXEHg=;
        b=D9IrWoMliC4j7FfiOXtcVKJm+6NPKZ6oksqPyUCd5D5T1WgTVWDBvDlmo2f1Z3q3MO
         j1Vc4thT9XcOp6QH+0T2vP9E6ph+l5bTz5lHCAeq7+R1INkmfUuZXpPRY2FpJQ3AhD2S
         QTL1r2v3tqmelcOR9L3xvqtEXpZAdtFGtgQpfER/CI9AknxmZuBRpWcMc/ukm75y5+ZC
         r5GskGgMpUVtHzeigCwLg23KbIb2nAU3pAJ1eKUEPQii/uM+pbTyNkkCWvBSaDAAxlH9
         izMaevRfvvVccHb1YxdklPrs/GIL2ua+YzeTEr1O+BYLatProI3m7/ReKdzkz8XjT78o
         OwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362383; x=1793967183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZKAADSfZoWv8xOE7quCSCjhwlCNy+kog5o59siXEHg=;
        b=MXaq3lQTrqXIrhQR6VR65ovqkbx7IMPNL6rQ9buWRCo9d0FksmxhVR+j1D9sdkCnuh
         +Sf25x1uzj8QIE33sbKHeyXk5DO53QJDlStHN3StfXdSTUGQR+ptXhzMa1vEL6HL0dNz
         3ZU/JX7zzrlaYSH98ogk33Y9rAErRcysXDe06UD2ZRnnTbnYrhtxupJ6h8QKHlK7waiK
         oQgFGEpNnlMMoBmdxQYKKf74wLmlyimkA5Hm9lAvoMJfM+SSF/Rw0zUXh8nNoC0GvC/Y
         WJiEsOGm6qOX1tkyNhcItBB9RYk9t1WQmmU5bavAowanoPNyJotFcdZ4pzyMXkAXg3xz
         t6oA==
X-Forwarded-Encrypted: i=1; AKwUvBxy9QkMy953yoUzdfwpRN5XFyxc4sW2OFYIsRwxvbOLOhp6Raly7HIDiSQSnwvIqTe7rmppUFn5h5Izc5eF@vger.kernel.org
X-Gm-Message-State: AFq9FYLgyekS92ZDMb9hb8DWrYIXEuxx5SU1VCWyhst4JgNfJT6zhF5B
	ye5hpNLV/0LWIQmlRWM7tA1kk5Ee2hvT8Hdf+DhM6r/ZJ8h4cEoYVhY79dMYrQFWcus=
X-Gm-Gg: AYBFou2Iu2FoFhk0oprobtS6csPQbsAWEI8roWfjYooN8jIEP/vvdJmOMQrfqlvNDGP
	NfMb/hfsTdAunEhlP7BCbZhLjpZ7v6wkDpmObrGGc+T84dbO6YP9YGQbnRhXmpjYc79br+BLITl
	ZSga6mFy1eHhDx/vDqoHLpIDdZpbNfWFsacaBHxHBq55GX/s6lhJ7Xsxq6XtavE17ES8b8u7JDH
	ZVeB2Ah3hHkaXwJpQKYTVKwoD9GSvCwDs67xUh+jOASXYCooRYYw9zKxvvF1dusyjF9CRx3BJn6
	jOI7KmYJJbHyEMUkEo9U1XFfGZ7SeyccmcuMXJdv7t0V5K+aEi4ZuoKrY8F7WZYQZm/LfHloY95
	tn2YYURt8zV8Ulr+Jwk95hyNaEs9DZgDIg9yIdmwca/60vH9MsaYNhw7qVWS56Dmhofy7uA9bmP
	be+q4oLCt7OxFW7mrHraKB3v3OQ/YDVUNhNl1U+k3bQmttNRQrS8NNakGGA8VjDd+gtqv04fuWe
	yJlls+Ue9puFEkqZXhDdmVoW8i3fknGOwR1Ra4w90lNALX+girFqVdZHmH0eJPRpFWgFeYOuYq6
	yJJQCJ/wcTiJz9OYg1gRZpUr+SqKNv/10TBjJ7nh3T07vgWOYBSQYE2J+jwfHU3yrcezuUwNHmW
	QfbJGS3U3L5s0N50/kKXR5BLUTAVN6wLh
X-Received: by 2002:a05:6214:1252:b0:917:7d92:6486 with SMTP id 6a1803df08f44-91ca4a0c511mr31768696d6.6.1793362383132;
        Fri, 30 Oct 2026 05:13:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e24001sm13957666d6.3.2026.10.30.05.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:13:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMlTf-00000000Zek-2qdZ;
	Fri, 30 Oct 2026 09:12:59 -0300
Date: Fri, 30 Oct 2026 09:12:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
Message-ID: <20261030121259.GC3889730@ziepe.ca>
References: <20261026220546.3114241-1-skhawaja@google.com>
 <CALCETrXNEWQNPjtuHnTfVFOafeJ7APXq288Cq16Q5adDNYx9+A@mail.gmail.com>
 <auEksxfAi9lHFXmT@google.com>
 <CALCETrXDY2e8x2kdr-FQvFLs-Y7FwNozXGDvqqM6yvVA7QLV3g@mail.gmail.com>
 <auPKfqh_YjRU9Ui3@google.com>
 <CALCETrUEyfvaEGxMHo=c0ia3CDgSxg-YW0_=Z7T31Ou+pvicuQ@mail.gmail.com>
 <CALCETrVpEP=HxVqdSP_AgA=U7ignwAgjz5Vi9+Z9dZsX5DXeLw@mail.gmail.com>
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
In-Reply-To: <CALCETrVpEP=HxVqdSP_AgA=U7ignwAgjz5Vi9+Z9dZsX5DXeLw@mail.gmail.com>

On Thu, Oct 29, 2026 at 07:11:25PM -0700, Andy Lutomirski wrote:

> I can't shake the feeling that the problem here isn't so much that KHO
> + iommofd doesn't like this but that the behavior in question is
> nonsensical.

It has been this way for ages, like David says if userspace shoot
itself in the foot it should not be surprised by this illogical
behavior..

You can get the same nonsenscial thing with just mmap too, you don't
even need a memfd.

Jason
