Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504886;
	b=3bXbTsKmE1FbDAfWepGyUlcgXftHMG+LMONCEGAsBhPyok7lu3lLzxZPoHuzB+2C6TIB
	 CW/8mpiQsvta0ALh6BnHLk8OmC5kczKe+BgI8o2EaNMv2onT01ct17aCqD2zpNLA66tvv
	 U1Gji2leghk9CkS2dq/dy6xuCikk0tZgNCTPccp9Fv9ajoAe/EpstKmtmA9DmL8m7LmqY
	 JINcWpz5TBXFJXq2hnP+jGHccacPjI1O0kjdT+41qqh3ldenhlEkXY6+J+3PyvL+W+HlI
	 oYYGjWDvLqnracvvn53OTs9Orr6F9272GoWHHl+inYmUAv1ZETqNFE61rhSNVel+lCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
	b=WHMXvDJ0TQbgrrAXBXYj7m8IrJc3b3PDIhYz0HtL+WXhmQ5rYZh6bGYNjNQmxfQdr3MF
	 SEWw3Z2uo7AeQXKCpMb2+yJAmIwmZ9ZjPug43GRq7JNTd6BOi1CztPhKLMhXOQS+qFDdH
	 4SQZMrNi9ugjjWQ7On06Ww39rzvEIevCeL5+VWSDJh4ah693M2d28/Bgoeo5QKA0B4U38
	 pRLUm4hRY8omQxb1O8fMOeDIhsikYXFiT4+oCmBcqGOIrByXRMo1mojy+N1MGa0g2pMZy
	 JzNS9q0HK2wXov4hI50as5nFHTSiH5CF6S1GnD37aTYK64U2imTvkpMhrsjRFongb5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=eK3atHbl;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39460A5BCC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC39460A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=eK3atHbl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso64816e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794504884; x=1795109684; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=eK3atHblxvr+4pedX5C9NMgUuOO7qMyRUqTGpjEsPliTYMpgW+MnogL9ooitt712kj
         fv8LH5pU1Rzw9z+j7MxH3BCO/KI0jEeTxFBRitYuqfY8ktD1K4y5fx0cUJJoE6IdERbn
         Bb4xwWPqVxafkISuEI1pWQ9y7sLRsNZtU3NMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504884; x=1795109684;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=pxXgXKwDBVS7faGHaP1kCTvwn1X4rUzMVdgUbeXbLEMpsqS73IpoPVl0DSaSW8GkCk
         2Nzz4h70h2bKZsh2M+JAI2KDjjvJ+7o0eCTvqPm0Y6q0UiB/deH9vkw8zUauHQAwhpZR
         jkjvt21D9hJvAn3Ow0xTWyEtx9lJzX/nWaLSgTPJr0R8GW+N2Ru8bdD/mAz1xD2aFS1M
         RVlKte1A7mwvd4OSxBtyA9R+98QsDJ+MxACBVRyCzvaDFCkJtIDdizGn+EanpCrzPykO
         GeO/T03b7oAG+JetHX7zR98GZU3Nzff4enyk8kaDTvfkIIrIsYhI05m8AirV5XqkyOUe
         qu6A==
X-Forwarded-Encrypted: i=1; AL+hErH4rEWmGHN04A+93udncRtC4zrBDLAtd5UoK1D/Eszy2Z2BNsiCQ4HlJ0erbbEKOELtzQnlvLzlBxtak7M4@vger.kernel.org
X-Gm-Message-State: APuU4Z8N0ypKH1XP2selSb4pIbColgu1QAXjRgjpgWNUP/JXd7n6P1Vp
	Vh5z9luOfdChG9KxBDQaS9ardMUnl9UJrJPJA8l453SbnEsJTJkWzHxXMQehGaBHAIgSl+9xSe1
	MZL9/+msRSQ==
X-Gm-Gg: AYBFou3rT7e5t8Qy3yJaD3IwnEQWMFzZLn0pFG6GwdUEetBxfE0vYIfskNXNpXDq2VS
	U72QPHihx0A/gVWIZis+3HL/jwEaSFDjKHAVSQKutdmBkKcy+p7F3qsqE9ubuBfdPXP5/ppPNJZ
	64cx/bCIVW9sJPotntpl0o9FCTRpF7E0Pnu09PAPChG/IaY6gc5KeDO8AcMnR+Fda1aSdUq/rHg
	wgCcO3dOPLTBBL4mP7tjStLNFEgbJyDvlCDmjO3ImB8YUPgevOnYKDA1MMRNJmB4zKpp3gtaQQD
	Zk0g5tEHD1oKGQg6JEE0evCuCpM2T/liS0croPnIo6USU519QL/NMJNJ/ZheRgfhZQTY5MQe6eA
	pxIqfuVWlu8H2xvx+bG7y50rpFEB7C0WCxO8aG1WBIWSt36jqt0JTcdytGIM2kXBUtnR9eP2Qbg
	gLe3Bc8Au3RWg53LQDS/SG1QqlRSgOV/Pz8oaw3q1w50jqJ40PNW5uQ4lkeRyov1Ul4GWnoWE/V
	A5sk3tghPblmPUsKvhLYR9MGGpjNlqlqA/WE5ylfz6Mtjcb9O3uXdT+naNfrQWewXsB4Jdt3yHG
	UituECJOMuxRL8LKjTK4bVcbcN9aqtP3rfIcs/7Co8qKetfTYzEVI9cHjJ+UlmXEUFA+djeDbzL
	ExOc=
X-Received: by 2002:a05:6512:104c:b0:5bf:b7d8:f38a with SMTP id 2adb3069b0e04-5c1709d9334mr27765e87.37.1794504884116;
        Thu, 12 Nov 2026 09:34:44 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bbea07sm1843566e87.82.2026.11.12.09.34.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:34:43 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c15ccd7fb5so62093e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:34:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFvp0MQgc8+NbHKCmLxSwgzQOlbtNBtRv2xmBbIp1MIK+FgShzhTNiFNtZRFvmFEl4Eznp1P0mL2HpvK/Ej@vger.kernel.org
X-Received: by 2002:a17:907:3ea7:b0:c4c:e344:ece7 with SMTP id
 a640c23a62f3a-c5066afe5dbmr615605366b.10.1794504534261; Thu, 12 Nov 2026
 09:28:54 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
 <avW3v-oLxcHXXNQD@pedro-suse.tail5790ac.ts.net> <4ae22b7a-c160-4003-a029-8a20381d196f@kernel.org>
 <avXFlI_5fhUvFyct@pedro-suse.tail5790ac.ts.net> <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
In-Reply-To: <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Nov 2026 09:28:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
X-Gm-Features: AclHuK90rViBZMbITCUjh4KTAKhE7_4EYJcdTbdgYzXWPc1JsLWFSAsYMdn-r7I
Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
 into pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
	Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-arch@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 06:31, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> On 11/12/26 15:00, Pedro Falcato wrote:
> >
> > ETOOMANYREFS I think is good, also EBUSY, EMLINK (though this would be weird)
> > or even a generic -EIO.
>
> So I used EFAULT because that's also what we currently return when
> generic_pipe_buf_get() fails through pipe_buf_get() in splice_pipe_to_pipe() and
> link_pipe().

Yes. It's not a very intuitive error code, I admit, but:

 (a) it *is* the error code we already use

 (b) it is a fairly unique error code that isn't normal (ie EINVAL etc
that can happen for multiple reasons)

 (c) this is  something that nobody should EVER EVER test for anyway

IOW, the actual error code doesn't matter. Nobody sane will ever care.
Some of them may be entirely unreachable due to resource allocation
issues. And we already use EFAULT for random historical reasons.

                Linus
