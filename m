Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492738;
	b=iejcJMcbK6yUPTOHtPQ7RxR1/UcEofHFNiRqMahFXZnEg4kLZ9HM136JUiuajgv2TG1y
	 +SlsGcIZDMXhss1+9XAGGUkjBnCL+EjYwUOjbAa6y5XOCprzF/+cSt6GY6En3gFLjmun3
	 rkEv0C/qerOaXLPEADO7EkRfLWqy9AXAvIeX4cP+Vxna92m/W1GnB3oyxAw15S6IQz9CD
	 RdBgQig9HSVAyOhdzY8/k+MSsmbC8+r9aAG5oGkKHVyJ+KCIIXav7OT1/9oNfpCfRqdcO
	 NiH9v/yBQzDCQiouIj+L9rmhx4wmetGprS2Bib3tQRTwZ9YQWC53b2qZKlq6uOEGh4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uM02Fg1gjU3NBZSPcxHW5Rd4yGFYmOd1Ea0CS7gM/Ms=;
	b=wShzo61FU7C3FVjvZ0oKfm/RfzRYIP2D0jviXoInL5r+7HXiGZ3IDZd0LzTd4cAxpjPN
	 OQZ6gt1Rw+3HKovI8DM2LRVPXGYEkOKbqF3qhB0XGppGBqvZ54ZxflxUPJvgfM9joNmwj
	 40fYpRO8p2FIn+BGkztv4AFl8F8bIMXOAdkIoVg8aC18VtYcjPdzWV0xF/xRWwe6CHT/B
	 mRskUW4T0/57t6nD1/UzFLO9M09Lx6fA8219WDadIaM4V0WOTYpyxrq/RXjwMvKBkFPNu
	 iHm6AEto8BzObxX2VnBwgXPiy0tHMBbMQz3+MDCewkHAeoJY5VQFt2AkmKXlCHTxmxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gAM4oD6u;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DB606A327
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 14:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61DB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gAM4oD6u
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso34053135e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794492736; x=1795097536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uM02Fg1gjU3NBZSPcxHW5Rd4yGFYmOd1Ea0CS7gM/Ms=;
        b=gAM4oD6uTHicKnz9f6XcRMaEiose74RSU+22HtrUNTVYwp1z4E+0jsTVXhaopMJhuT
         pjs4A65NOnqmzswNjZyNhEselwzTsfg+DahHBo3oXTJoc0kQ/aoomF0w/MnekRyv/0cV
         CCxrtZxViKMXI3LNnyKnDxqhPmzivgpxsBCnS8d2L74xih/EW5CodlRtaM23ZtLqYkXv
         m/OAVrSVnx/aSsd3jAruqfNVGYJvlp8Un5NBSNi4cFxU0OV6uxzoDBD8L5S66G7WMZob
         8Gfo1jphMoQx20P3Qs6ZvBIsuaBUWw7P099WzOZENsx5TTGTQt3eXcWPUOrCWT/0c/pO
         p2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492736; x=1795097536;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uM02Fg1gjU3NBZSPcxHW5Rd4yGFYmOd1Ea0CS7gM/Ms=;
        b=kmK6kuoJWREmf+mAIzdRbzdL7mMgm4XgtugEdU+GOKUMljUAcpl29gAnVUpQc89XAj
         Mydh5ApfqJ1IkLTuBBEejDafIcxzPFnPxzFkCPSLHnMnk6qTW2BrfVt3oOyQTSuYflSL
         FRl4nK2ZFN+E3BpY6AlWP2nE3q3R5X5i+3WAo82wT55UdX0hQUXdprFY7ws4e90MqeqI
         fjYVtH/Sjxh7ToEe84jKIoOEO1MS4VaV7e6RkqC6hOVTQCBYBCn9HRiiTR/8ZmNkrp0c
         TqDtZv0IsiYH4mxuPmUU7EzkR+VzYK6SEsLHO7WRlX/T4buTBpjgAELCTF/K0VLO++7O
         HxWA==
X-Forwarded-Encrypted: i=1; AL+hErFEj7i/KI7FS8Xx4Z/3yxs7HTmaFqk3HyrNg4LDlSppOtV6QVZPB36vbxAkQNkj+YQP3pzH4i7fHVu9+IHZ@vger.kernel.org
X-Gm-Message-State: APuU4Z9rsIMxaBZTgFbn0qqOifZOsBbwSUDolwfsFI9dGR8gTww9s8pM
	5ATNPVMFW4hp6VDaoUJLTkVz4RyaZ2ITypf/fjnaG76kG4OK6x23I+yuUF+U104avo0=
X-Gm-Gg: AYBFou3rx2IVuymq6Tf+qRx42BJObXKUC/K+MiI3QL+ggDajHvtUihJOkN/w81zJpVW
	1aVfYiraifTuz/n5WVCSbxS0v9f+BtYqDwYTASIYDgCQiLpaHcHN5GSkCMoW2KXPvg5/7PeZJAO
	dUXiqcDuYMVKrlreelRtdsXm9CndRX/RztyeHvY5A1+U958aoVnKH2nKFxReWdwGPV2QErDAfwh
	6kl51mSUbBG3F6952W2AnH/Ig0neLPTaFwKSQ2ZPl10FhipU8lZUv6z2Wx5xlF655sCe6mvmcQq
	qQWSBffrh64QUKzxjTm/j5b5Py4TRg2L6P7IFl/QJ8njmJl5XLJHibBbcgI3lfJV6Tsp8eqXAdG
	ZbuT7cigHXAuOYOWoghD2lrpAn+nz99yihmPd4xU1HEEE5biFUdp/e4LoYYt2iLRf7u/AY8we9a
	WK6GSlE/xA84xmxzHaUSt1nDFn4N+/N2OQ6zVEGpK302O++Nwa/jNj25Sa3wAa9SKm0tYDaU6EA
	t+oqXQeMvUWpPYFF+/YgvtO6tkasKJNV10Eiv5FiBy3GWbgB34ItqD7a6yp2PTiCULpIixOq1yH
	0X15bvwSWwj6O2h4sCZZ0cpX2qBHPwJPLKD/9rzTbBQw
X-Received: by 2002:a05:600c:8b31:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4ba0938e3aamr97570525e9.23.1794492736131;
        Thu, 12 Nov 2026 06:12:16 -0800 (PST)
Received: from localhost (109-81-94-245.rct.o2.cz. [109.81.94.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2776casm105702275e9.14.2026.11.12.06.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:12:15 -0800 (PST)
Date: Thu, 12 Nov 2026 15:12:15 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
	Balbir Singh <balbirs@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>,
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avXJPw17fWvLtCO8@tiehlicka>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWmfXu39vtp0DM9@tiehlicka>
 <avWsG-zmuniUFio7@gremlin>
 <avW1s2wvz1PB0-Ln@tiehlicka>
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
In-Reply-To: <avW1s2wvz1PB0-Ln@tiehlicka>

On Thu 12-11-26 13:48:53, Michal Hocko wrote:
> > This only matters for the OOM victim, hence reinstating MMF_OOM_VICTIM, which
> > made the patch _way_ smaller than the one proposed :)
> 
> Should we simply do that flushing unconditionally before setting MMF_OOM_VICTIM
> then?

Sorry, I was caught in calls and didn't get much time to think about
this.  I have only now found some time to look into that and to do the
above we would need to make tlb_batch_list_free visible and conditional.
Which is a bit of undertaking, not anything major but still kind of
ugly. So your solution seems better in the end.

Please clarify the changelog wording to be really about this and with
that
Acked-by: Michal Hocko <mnhocko@suse.com

Thanks!
-- 
Michal Hocko
SUSE Labs
