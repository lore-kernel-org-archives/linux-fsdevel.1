Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF482866
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.139.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253913; cv=pass; b=QdRduG6yM5jnWfC9eH8tzicPe8RiLQ7OVkgrBROl+/6G7BqiZ1EbcXg24Af5pjgyrj48k1MWwS5Bx3ptZT6KXZMHYtqH5V5w6LYCvERxJNhXYXl/j2Jx9u+mKYbJ0T8pXyq0cXkV8HHL41pkA3e3NRTcfSyO35oGrvf38MJNybg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253913; c=relaxed/simple;
	bh=Cq8+tWfGf0TNmdPtc7SAv9a2DVpNwq16jsP0bVMh1cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/sh2f1D0v5r0f48SkONPDbolth6aumQC1pPeh21o/e07LZMOq9vtMrzer1GJFGgQgIptsxELx8YGFrE9Qq1ym6pj55E0Eml3cDtsL5C+mnLCxNLsl8xzR8Zz+i6nN+vB/5WZ50an3BN1KCwCfm202X5U6knrqwC/cmRm/vW1hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UUM+ow1l; arc=pass smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UUM+ow1l"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BIDGOG1911278
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 14:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Cq8+
	tWfGf0TNmdPtc7SAv9a2DVpNwq16jsP0bVMh1cM=; b=UUM+ow1l9Ax4aODk3kCA
	f7C6HX+J1u99B/02owTapIzmg/S3suK/So7h+9shCsOsMY31YQ+ehmWLJShBDZtJ
	XSPB3SYVeDnU5cbRSko0FZu01N7ob0aWMQCkAQxNNKfYhkrHloUojrVFq2qb+lrm
	6SwDtWiAxy8bBpNfFnmfwdfuhUVGAAvvZtsQsPKsxGPE9DClIL++hxAb18jfEGmt
	XOjrspU7yPFaEr4YHZgDT7jQr7AF4Oi1HRsZTHLlWuzw7s9+LBlcYmbUdLVRCZms
	ao5ZTen4Lmub3RDeEx9C7ttLVWXnex1T9F2275PLGcL4nuBCa3SsS9N40ALWOpX0
	YQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4cuawa1ket-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 14:21:01 -0400 (EDT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7983f854288so3689627b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 11:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773253261; cv=none;
        d=google.com; s=arc-20240605;
        b=S0VSqb60ZbkdnmV+RPLzf/168Zzqq4jtCX8+URwlP0cacHnzvaAvFhCUGLi81494YV
         gFIrEi2eyvhQV8mklxED8o53K1sfGScXq+GXfy9JFvFxypm+bVWoA3AbVbCLi7TK7KS6
         qU0F4TNRRHOo+Ljk8irKT18/7ePMVViVwMnWg+E8oq5X3Mer/tzd0OM5I3jA69hYq2On
         mstcC56OPtNKEhx5f7f6modUUncsGy3OlsJ00CGf0HHexTIgQTLSWc7j/DiQaLPdBohW
         KGcBrl+JU2GhGjV67gVf7LbQvcxD//cuUtojfzIS1qU8igl1TT76aXuKOhYehTA095tC
         hpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Cq8+tWfGf0TNmdPtc7SAv9a2DVpNwq16jsP0bVMh1cM=;
        fh=xUbQGyV0XzEHRQCwcvtfaBaLgaLQp7mbrh5XRNgtBQw=;
        b=W8qQTgGp9PyUzOoHBb//Yq+IBIZL9aE8v4FHNHs2Xv/pwTxYVjJ7rJc4X186Btrr3x
         mYP7PCK/tmgoCQjVPTbZ1iuruHR2XxeJ+W/uo6fLDbd7NgxeN40amxYWW8xJPQdzJAGA
         WnLgafTRuWpoAUZ3ij+1hK0Y+/mmeG/fCSSSSWd6mIraYxCFodWxgnGLrLuIktfm8hrW
         DG/1q9Cj+gomI+4xmPAB0K77mOIBwSKGqGj9N+0t/1/uMhR03a6gQzPNIskAsG9Mue2K
         RmOk0SdEMBkEdN3gbWc9a4CsL+/aYDHYnyrd2+6erXqgIM16y37fpSp3yuejbL3XaQ85
         SFsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253261; x=1773858061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cq8+tWfGf0TNmdPtc7SAv9a2DVpNwq16jsP0bVMh1cM=;
        b=D74onFcPi9sC/AFUCroC0pbCiXZzISSEQ10VGc9iRCS0MjWdbe80BZA4ODgS7792Rb
         APcGKO2ZcGNb5KsdhuK4Zm5UQbvDUetS7DjUOYois1OyX83W9nNk9Yg8fShb+U7F9b4F
         84azwafvs5UYx2OOMFKXNTaIcbtd9gnLptSz7jU8Da+e1iy29Y0gV2qL7gjR3Yzo1/o9
         N+tP8QosXacKsk33qKijmYElT8y9qLerwtGqYQ2+Y37SaqbSIbwHeS/wYS0xQj8xa+g7
         9EO43XgdT0aj5dO3uj81eh19yuf/hesSEpRZnVWxkMLDCm5UqNN0z2ao6AimVHUkL8Pl
         Zr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO3Jzx3iy8DTcA2T/YQAO2rpVWP8oCFbPG5YGGzhyCK5igZUmLcw7IH37dppyL0IbNDUR0i2Kx+soasyu6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/PeL9FqtpaWnjIw529hNRtPoz0QXH7advr0DvDEs2iBNquPZ
	wqrMbnvz/1qIRXg9PZ5zu554ARgQr0XcLau5O2SMz/kEtJnPPoq0OK4XvUz3/scME6f63VPtuf1
	I0ZmDFEJeWnPYLwMyxOL5S1fOQ6G+A8XsztBdrYXCjBsdsD/lmjN1ZB8QwteNdf9eczfV+dSzk+
	fE+3iLyMeFr9ikSOYa5Fd4/XZqEEtfdkgZDcnQ2w==
X-Gm-Gg: ATEYQzzqmwbcYs+DyiL0mu8rr7hCbrox+TULaAKCDdHs6KfN55DGcdKqOh0LIsOvgmO
	rs2HTeOKBC7SfZ0mgZ0Tl5Kj1JGXACNYOb1hdhagXgpQHwKOF1U7YBNYDuzv1Da03abTbhf17xh
	wQniaAo/OjyuOll4/xxtGhLYpbsIcCybCjN8Qlgs970zvbWe2qs0571OSixdoRRKRk5dqVyW8aq
	BzOFejz
X-Received: by 2002:a05:690c:2704:b0:798:e281:a51d with SMTP id 00721157ae682-79917f7333dmr31676437b3.32.1773253261155;
        Wed, 11 Mar 2026 11:21:01 -0700 (PDT)
X-Received: by 2002:a05:690c:2704:b0:798:e281:a51d with SMTP id
 00721157ae682-79917f7333dmr31676087b3.32.1773253260648; Wed, 11 Mar 2026
 11:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
 <20260227-blk-dontcache-v3-1-cd309ccd5868@columbia.edu> <wen63cjbk3k54mjzgw7zftsuze6bzxmdk5u5wdjabzdiqg645k@67666k5lrevh>
 <aaXK0_HqEnU5SK61@casper.infradead.org> <aaybsigvp33i54w244jy4jarwf53zph5mzwjy2hcfm4v7m5o5o@e5hljmjqa3kq>
In-Reply-To: <aaybsigvp33i54w244jy4jarwf53zph5mzwjy2hcfm4v7m5o5o@e5hljmjqa3kq>
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Mar 2026 14:20:49 -0400
X-Gm-Features: AaiRm52QGrwhBIHZ_poQdAn3zaJ3OJ_GcxWQiC5XIABJrq0SVTc4spz01Omwcfs
Message-ID: <CAKha_sp3nF=UbVd3tjie2qat44P3_puZLABWJRXs24SLVpG+gQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] filemap: defer dropbehind invalidation from
 IRQ context
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: aSFCMkEQMjPm1KbQK1Mre42Ieu7_7LOE
X-Authority-Analysis: v=2.4 cv=ev3SD4pX c=1 sm=1 tr=0 ts=69b1b28d cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=jHxIr1HyPKZ_Q5_91PL3:22 a=-5RlsJUDQDLQn6G50gQA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: aSFCMkEQMjPm1KbQK1Mre42Ieu7_7LOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE1NSBTYWx0ZWRfX4lShiW5xF9Ug
 gd8jJHPKZpSeqwRIBWUJaA6qSXMXZjX+Eas0PHRz6LFhv2hIhAKpN2zRG2d589uRavgZb2fnGSo
 jSNwmPqaCQI+LvuV/Th0DQkvfAphrq5X73+QzqksILqdGkJZa0gUlIsCgaGhUljaPNKdk8CCqBz
 m3jE20yIykBj+3zV3WZTlcGzpiaZxBLCelshRDbNEoyvjpwUrpBwmAdNA7oBrbdcIj9JfIhVAFp
 DdCipHOW80kIHtTaXsHRX+aj9or1H+vlGHth69cuIH7rFM1RomrzoOSsOUjlmzFJqrAUeUWbtCD
 oGpAKCdU+BjvFQ5IsmPqJQrnUspaK4rLxDbTP2LiCueagKv95FAGltHVWCJ7ROs2ksy+rQGregN
 ln2EAPCuvJojNy7Nwbr9cvtCN23UUZRoU6TqQrH1tx9c1mqOUOuPQaI0BMeHhHz4pMJYMHdJbOe
 oDV1mpUhSqmSw4H93Qw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11726
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 impostorscore=10 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=10 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110155

On Tue, Mar 3, 2026 at 5:39=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> On Mon 02-03-26 17:37:23, Matthew Wilcox wrote:
> > On Mon, Mar 02, 2026 at 10:11:19AM +0100, Jan Kara wrote:
> > > Folio batches are relatively small (31 folios). With 4k folios it is =
very
> > > easy to overflow the batch with a single IO completion. Large folios =
will
> > > obviously make this less likely but I'm not sure reasonable working o=
f
> > > dropbehind should be dependent on large folios... Not sure how to bes=
t
> > > address this though. We could use larger batches but that would mean =
using
> > > our own array of folios instead of folio_batch.
> >
> > That's why I think we should allow the bio to be tagged as
> > "finish the bio in workqueue context",
>
> Yeah, what you suggested there makes sense to me. The workqueue would
> probably have to be a per-cpu one for performance reasons but otherwise I
> think it's worth a try.

If the consensus is that completing tagged bios in workqueues is the right
approach, I can give that a shot based on Matthew's suggestion.

Jens, does that approach sound reasonable to you?

Thanks,
Tal
