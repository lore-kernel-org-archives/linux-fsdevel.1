Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609240B379
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788028982; cv=none; b=GdJCfYLxT5Bxd5o2e9Qw8GCNad+Q0y35ajHg0PqsCI2BDG2KtnzadVeHxJhxQv02+pw+PcPLDZpRItghr+8c+3ex7LMbLklg62JR0uqGWquvb883gk0E1L17vUvThQjH4rpxENGJfmZRSgDlp7cwhrgIQrwMXd7o8crvnx/x51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788028982; c=relaxed/simple;
	bh=8Gj2G76gEDUSTrJh9wyKhjlV0WDG+1riVaR0UmTV1c4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=pLkHNXCM+OF5/Vxk8c6ojAHSwAS+eIJmhRvhzv5L0EyN7ktOkSMdxqsYMtFYxEupD5evRWQ56bPcaizujTB+W3EkwPj5pohu1XQ8qD9yGtOFbaYqIGo9G17r75rmyAivgCNVqGdoWUegsnpqsYUQawAFF4FbA1keFHaSJEkOcWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=YaJycs+P; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=xJMFBU7G; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="YaJycs+P";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="xJMFBU7G"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67TIZWoA1920303
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 14:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=0bd5
	PAmYpGy8JaYT1BKzRh2l/HCvYP+lW1f+KIURCm8=; b=YaJycs+PgkXAxiEmTQzc
	x40/bpBx1OYZh241szBo3lKKjWsHNNTm/SUNCPAfRi3n/VvGgS3pPmiT6vJfeTeE
	GiYqlQAcB9LxnBFHNoESzb5esOccev9qrcQWHm0gEHQGot5RZ3TlnUHgTh1mlvDz
	d9N5rHFvicpTxBVJ1Kc7qEh1Y27NhJ6xXj8g377SAqIe5++so+krlfoZAvQs/gIU
	kCMT6z/E5NYAilPWjvHEyj6ymy4uPe3Gtsnyao6hjzXSseIMYastb0rZJFYPC+xh
	8rKV341s6RpP56zWTz8d8V831a4RBpe5IcA1BvubzOBoLFQUXRg3oy5g0dCR/q6W
	2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gbqy7b0u3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 14:42:59 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93915f50a5cso381309985a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788028979; x=1788633779; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0bd5PAmYpGy8JaYT1BKzRh2l/HCvYP+lW1f+KIURCm8=;
        b=xJMFBU7GQCayIbfE/cZMP8mwh0IfylQylrPhUpZBxmpVYi2RVGAjfDyeBsDEwx9xzd
         TfrpRpffrA/wJ6xl9pQYcSVBhmEKp9cDktrlyJojPzwSDh4OA40bIIK/lPQYNv4qiejL
         Ui4/zvXdVV1fseG53Y3bbx05exgxDw/IqliY8WXjDbo65O8jB2hu4kgVxZV9V+4phyKk
         1KyvFBv7Q8Oj9PIPcEy99NQJ6X0Y9HpYMDP1lDnhiAQc4uLTX1Y6+HABwvmdTv/BthEj
         quQK3NYVN5hBoiMWWqQpwMP+iIedprzIMuUaz/g9KiNUtGdZnLUjB709S9MnDJCQyu9H
         q9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788028979; x=1788633779;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bd5PAmYpGy8JaYT1BKzRh2l/HCvYP+lW1f+KIURCm8=;
        b=qlQzkgaMXV1e0GvnbMKBciJ0W+BYMiV5iZoHGka6oPm4ox5jmUbmrWRxUYkWKiC4J6
         LjvAZ46JZGSgLsZbX24I3Qi5B6yLGOsZRgctlFl70gC9dbc7NNpgKnrkhpfyU58mdD2U
         mMvqduBFsps7ARgcwkW1m0DoF6WPmLGnznRfR6w+ryuX4Eh3a2mUA7eq4XLUT3DzDTix
         d7TndhAkg/zEwh1ZFU1OnZLkq+8MqtXQ61au/o8A0PZhO6ISht/yQvXln5g/PmSSPXMK
         0MR4/fKTxpYtUO7+cl8CLHeQbVZ/YLySxTHoPqw1RTxSN1IW2FstjDKhPyhls/GDikWJ
         FosQ==
X-Forwarded-Encrypted: i=1; AHgh+RriRSBerEUgENr9pvQXASaqbJPisF/Qz0fnVUMA/PcD+g9aH7thBApjA+SJc3A2ZOQSBUmmYjE8pj5I3iJ9@vger.kernel.org
X-Gm-Message-State: AFuF++mHKmD6+2jQg7lz4QhRk9Gqd0VSZd8kD2oAF1+SJ0YWb8XlDEIa
	ZndtSBLZpqbhx5tG5Z0J5C8a9bSNGgBuQd7K9+ukOftE+nw/SJd4Fi8o5h27aGGFHwFAnNaqVS5
	LidLImZ+7RpUJYmheFtkG6xsFosHfFUBg6OcW2YXaY+xngb2iXnyhABc2CHhv0wY=
X-Gm-Gg: AR+sD11UBlcv2qGdVKBnehf0A/lLyb/qDwY7Ixj2rH3JpG9srlB2syCPhBmm4+hoD1L
	ocQYRmWqmvPf9szkW6Wsl7mtB5AJ3G/RIuNvCcbxOlj5yHpYx0vB5YWwP/b8EuQyQmVEEPdtRgE
	x8tgs2sFNpYEjfoqPi78XBqgRcTSBAQ7vV0h8cBp7k5+ABR+4lj0eXp5+nsivY0SHaU/eXKiVTZ
	dFrhz6iWm35OB0qdufepPSsLi999613/TJJeZhs8hlbcWkpZBfUFZF86qFDw1shoFnSY8pwkR+9
	93Dgi78nmi8V94o2TEQiw+07VtXp/InMNMxqy9q/b3bnm7HUbSQmXtX64hTHaIQYsEBrG1q0QIO
	6BdpydYguNu0Gr1Hlo97qtBtJ7xFdJAkUSNCaEkRAShEe3yw=
X-Received: by 2002:a05:622a:1910:b0:52e:4982:22cc with SMTP id d75a77b69052e-52fa1a4aab2mr249923051cf.5.1788028979070;
        Sat, 29 Aug 2026 11:42:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1910:b0:52e:4982:22cc with SMTP id d75a77b69052e-52fa1a4aab2mr249922571cf.5.1788028978606;
        Sat, 29 Aug 2026 11:42:58 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb32d30sm12171637f8f.34.2026.08.29.11.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 11:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6/6] userfaultfd: collapse
 VM_UFFD_{MISSING,WP,MINOR,RWP} into single VM_UFFD
From: Tal Zussman <tz2294@columbia.edu>
To: Mike Rapoport <rppt@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
        "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>,
        "Liam R. Howlett" <liam@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
        Nico Pache <nico.pache@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Usama Arif <usama.arif@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
        Zi Yan <ziy@nvidia.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <apK7s4xSgA_GmY7d@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-6-3086981b33cf@kernel.org>
 <ao16VxNvaYzlt2WG@gremlin> <ao_9R3CbjYFipFu7@kernel.org>
 <apAB9GSnHNyNoSc1@gremlin> <apAcweThjiD-iIBF@gremlin>
 <37f6af95-950e-4457-886e-6548d4719f0d@kernel.org>
 <apK7s4xSgA_GmY7d@kernel.org>
Date: Sat, 29 Aug 2026 14:42:52 -0400
Message-Id: <178802897277.671075.10362065249796431311.b4-reply@b4>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788028972; l=1768;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8Gj2G76gEDUSTrJh9wyKhjlV0WDG+1riVaR0UmTV1c4=;
 b=cMv3WyS297uSy6OhyEPKL7TFiV6NgPyRlli6/52vFPU3U+wxk43IDrwyt65mNyPQi/updU28Q
 fXkQOPOdareAvP+hQQ2rgHqvMZY30DpDTGX/m0/lnTSj2MdkKXGNeAi
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDE2MCBTYWx0ZWRfX0TG+imPgITSK
 0ICMjk2WH+Ypz/4PxHxsdRj2dHGUUO6+ieqCeSg0wt5uoNwq74IGIT6Opu6rIGGeJKit42uJMkP
 ggrY3UmvLGnFFuF+8PW8OUkGYjIiBAhFb1aihjW6SJr9qDwOha/w
X-Authority-Analysis: v=2.4 cv=e+I2j6p/ c=1 sm=1 tr=0 ts=6a932833 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=kX8B4L1VaituP6mSkuYA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ONVZyXB6sl2fEKbPhTpQag-oCJsG5VqH
X-Proofpoint-GUID: ONVZyXB6sl2fEKbPhTpQag-oCJsG5VqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDE2MCBTYWx0ZWRfX+3X9znLA8IhI
 6UaBpe8MiObqIumYlQrr8ZSJb3sJ0uNSVpSjFtwRO2PZhNXF3lHdX0l/2+KDpsi9lBqMO/NPxIM
 tDyez8fB/mhqcwgvW0mXTfsxj4myo7jiXYPYAmEj9IQsr3pA3UR1X1p7AAKUdZxAbE7XDcca0PN
 VIoDfkKGCAx5bEBbTNnJb1RDo9USMGxd9NE9UWN4exkEGUxdYP0Fo8884HVpJmU3xLuAnU16oCu
 CSgHao6lMrmktOINOgClOHZiyAB4jzx7DnmKSTdEHa/IfNbjhr5tjijFmu3wg/OV01ey0zLvFs6
 hOhljubAadpGOOEYenXXpo1AfZDy0CCqfNWSQLMbqo2Evg+egGiM/Sl9C/z1YgYzZikfeIH/rdN
 wpjsKJ4Veen2OKo0LQm0Uu3MB4nB7ropBlwSXm+aGQIioXgfM0/88DS5NjmUwlskLaRb9GT2jm4
 44g+XwGOpV4ITVT7oLQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11890
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290160

On 2026-08-29 14:00 +0300, Mike Rapoport wrote:
> On Thu, Aug 27, 2026 at 05:19:30PM +0200, David Hildenbrand (Arm) wrote:
> > On 8/27/26 13:18, Lorenzo Stoakes (ARM) wrote:
> > > On Thu, Aug 27, 2026 at 12:16:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> > >> So actually you're increasing by a cacheline and increasing the VMA size by
> > >> 64 bytes, i.e. 1/3, which is unacceptable obviously.
> > >>
> > >> Maybe there's something that can be done with:
> > >>
> > >> 		/* forced alignments: 1 */
> > >>
> > >> Perhaps? But that looks potentially ugly.
> > >>
> > > 
> > > I say elsewhere (or think I do) but to highlight - I think probably we could fix
> > > this by putting the flags in the low bits of vm_uffd_state.ctx?
> > 
> > if that's possible that would be clearly preferable memory-wise.
> 
> This gives only 4 bits and makes this completely not extendable.

Wouldn't it be 6 bits? struct userfaultfd_ctx is allocated with
kmem_cache_create() and SLAB_HWCACHE_ALIGN, and most of the flags are
only available on 64 bit, so it should be 64-byte aligned in the
relevant cases.

(Not that 6 is that much better than 4... but it's a little more wiggle
room.)

It could in theory also be bumped up to 7 by setting align in
kmem_cache_create(). userfaultfd_ctx already takes 192 bytes due to
existing alignment. Aligning it to 128 bytes would make it 256 bytes,
adding 64 bytes to each uffd rather than each VMA. But this sounds like
more pain for little gain :)

> So I think I'll drop this for now and wait until VMA grows another cache
> line or until having per-VMA uffd state rather than a pointer to per-fd
> context is a must.
>  
> > -- 
> > Cheers,
> > 
> > David
> 
> -- 
> Sincerely yours,
> Mike.
> 
> 


