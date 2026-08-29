Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F673B47D6
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788018813; cv=none; b=PpHXwwJwPWj4XytzSvJU8Qac07nmZgEQGeVf73UvJ/Ks/i9gwnRO0sDCXOBG/YNc+85DoZ71cqpIWpfw3+qD+RL24QqxEIarD2jC64VtYnhHLyPsbr+vKzI1v5xH0oimYp6GD11w93mkYQpJj+1Pyy1Qgag4EjTfay8B3nJ2LXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788018813; c=relaxed/simple;
	bh=qh51favisqRYFIIJw45kc1LAAx7fR21479+AvfqL/04=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=l2LX6WHQ57zUm7UOztHTABlxEQ0PVmaF3k/Fcn34GGzaQsWy00+ua23kMnwVFVjHobiLZHOtpRzGC8IQ3R6Uh4Kx66lJd4dTpYvnGkYbBwLCCW/yfXm5sNgRq+dfiFdmybFKZizr1qBA1B2R9GDJPf5psIT7n66B3Y9AmnVcFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=o+T9xXEZ; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ARM4OXAx; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="o+T9xXEZ";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ARM4OXAx"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67TEfZns1323614
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 11:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=8ymD
	ovfw/EFXV/LaI27PWgfgegjJSquVlVvW7s1UYGk=; b=o+T9xXEZ8enT9OA0oMXX
	MAwHYlBvVBNQq/jeJDWvIJXTZNvcPRZPR/NMQFGbDwud9gBXxSv8nupTfqjdIWum
	JPRQsdHKxBJSdb+bbK2Ast6AriOck1LKP3Y5rLtlAuImz53Tc6zsuWqevgLS4Hlk
	XI79aokYsSont52zNxNWqDAUdn+59yzIAUgpgRrUlZoGDmKysiWCNF/Ki8xGH2eZ
	Jtuyaxv66aS5sDXDd9d+V1erALxlKH4hruwqaIBo9r+OMsauBA8rrQhbAQ+DPnRC
	cIXQWQ/FW2jfmg/e9gIdFZhYND1MKch2MKuDbyTmyKc/XXZU7N2yjNsowcRP1bXW
	fQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gbsppa7q2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 11:53:30 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0e702df8so52691201cf.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788018810; x=1788623610; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8ymDovfw/EFXV/LaI27PWgfgegjJSquVlVvW7s1UYGk=;
        b=ARM4OXAxJ8OD1ekaLY2EjpsCqf7c5fsAVJTa7kzpPJzashDCH6KTmyTZOJN1iHLmUG
         +7aLtDg+cqD77vwc3OO9v5toGU2SUU/Q0PhkTWeO7kHybEj/EUxzoAdyudyCPxjzqC2E
         r1j5NpUKzy8JNI84gPZtntS1eMRMdN9NuA9jSECefgirD4YlljplUxH3VfTUnPii1m30
         c8aO/fWC7VUGJaZ2fLgpgZJCxDx4p18Uy3tMq1VsgnpQhwFkEQAqlSrz2dKNsKO2y1dT
         l+ZxsgoOCbVoCvr6JQcPpXp++7ZCXsszNk8j1L1QxkFNb8BnZ8ngWH89Q7kU/gvJUak1
         N8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788018810; x=1788623610;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ymDovfw/EFXV/LaI27PWgfgegjJSquVlVvW7s1UYGk=;
        b=JG9PRwJ/cB82+pJC5qqYCOneDXh21SbBvPi95Lly0Q88jx+EEXH5vJZQAVEmhkKMFF
         k0LZR/gkEDRGDbeNxrsg6OnxdyP4fptCM1LO1KWqxPDJxmuvXx0WEQavXGPWVoNAKDPm
         H6NVrBP7WYMQEidh+X/oLJAKP51F/mcZJz9avFD3sG2c6Su/sPKuznCup/UOOxcnHxO9
         XykKzthuWlPEIxyq4pINwT6V+EZjypMl8+8sw6NcRHjeyt5rn0XtG/7P0+EH0sTwgYcY
         wr1AG3kUQntQtZceFXe9JRR9HnjD/QrvK8OxEafibEpebjm55X+IeN21AZPwgJ8bqjm5
         tQOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrr4GZeKSHJQ7URqQ3+egDyY5HFszyJoHRoHszP0yXmphi9oVI1rdJd6qBpVX6VY60Mstb+c3b8BJ+DfDx0@vger.kernel.org
X-Gm-Message-State: AFuF++nuoYV7OABXNuJ4Vp7eZ4QTboMJJvbKlKehA7T1jb8lHjTsNQ2K
	/kNr/AnJ221uHiEBS9h+dHL6emXMPR5OV9i5UdpJjQ7e+5o002nDflNkY8/7xrcIcMxj/7E4+EX
	6t4Tyy+gguxJhH6m4iuyGjZxaRGaViA+E4zAd3Ml6MkJaiyD0bdmRmbdj+IrL0AY=
X-Gm-Gg: AR+sD122BY7ghUQ1bZKNmSXqYwI9KCBfiovA/qribS/gvDFnNIoWK4I8+JYQjilmTNX
	5tKiOGqXoUQp/2yA0t/C4yi6pduCjXcnDaOivpeQV0KrfFukfxvMUK0jdgqNCRkL8BHnW1R6rjU
	Ad8xk3EDWxpDCHHMOEI4iE2lqVWCexUETX3nBDk7U3eKDxUTVQOtGDy5aBL7i77nhUqiMrPbi3z
	uw+6oTgzHhRndgXBSMs2d4ZqkIMesWchn5Wj0bjW4PMQNg0O2gePesM2Rwx0YvkBKhdCcolFYCq
	PS/PYAwTa0xKj+x9Az272kKfj7NJNf3/wumwrjdxXmIGV7ZgvKaoi1L8ryeRF/JtUGtikVaTjMZ
	NaMYf1QWDiysIXzUDY1zWGHmmQygl3UssASt7ph4VIg==
X-Received: by 2002:ac8:58c8:0:b0:52f:f546:c683 with SMTP id d75a77b69052e-52ff546dc18mr97024161cf.29.1788018809917;
        Sat, 29 Aug 2026 08:53:29 -0700 (PDT)
X-Received: by 2002:ac8:58c8:0:b0:52f:f546:c683 with SMTP id d75a77b69052e-52ff546dc18mr97023781cf.29.1788018809486;
        Sat, 29 Aug 2026 08:53:29 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a8e0657sm108099655e9.13.2026.08.29.08.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 08:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] mm: filemap: retain mapped dropbehind folios
From: Tal Zussman <tz2294@columbia.edu>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, baohua@kernel.org, axboe@kernel.dk,
        trond.myklebust@hammerspace.com, qiwenjie@xiaomi.com
In-Reply-To: <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
 <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
Date: Sat, 29 Aug 2026 11:53:20 -0400
Message-Id: <178801880005.667254.16521776519325089161.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788018806; l=870;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=qh51favisqRYFIIJw45kc1LAAx7fR21479+AvfqL/04=;
 b=9D2u9tIK2luFb739fqW5+911YvX99bhciYQK2e9hDkpVr5QE+J47y/qLzFvrZsNOv4iZBwOd+
 88JH/jEfrXMAg8nXG80s4x1xQYClTr9LeVpgl9V2v1bUAu3R3xvjiUE
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: wzZBxJlWc-PeqeWOIBhjVVwMV7rG4-hw
X-Authority-Analysis: v=2.4 cv=B6qJFutM c=1 sm=1 tr=0 ts=6a93007a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=pGLkceISAAAA:8 a=IeNN-m2dAAAA:8 a=Xs2TF1iIujOxxFI1s40A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEzNyBTYWx0ZWRfX9wJsgfPTmqQW
 15dPzo9CIWQV2NViWiJ6AanyFmY4RN0/nd2VnQ9EuHXtVn0p4gvn8k1rGH17Q4xwiEqlqpuhswH
 bsSpE0VIQZFsogIgx0k6ItsMlpONcIEb0liLiyuyPX82St4H3fQEV7eLTUxEuez8MfS8sXR3tTS
 6wB6gJhEObRdVVPD4xshTye6VBJQYGflwHEhkmdhEg/9/g5FScUbTHaGsmHdDMqWoPN90xWFwjj
 YC7sanApGs81IdGBxdgnJRjyWOcwVTKoctIbN3r4oeVXzIEyaSaKDtPMzH164xklHbq3rRILRv9
 Nqv1X+Ew7f2OTbqVZNoB+AX/7RfBSapgLHgWjNoMHnGBetMfOegqolBgeRZaZdzdpQa+tiTYnss
 e+IrT6tWoyz/6Mfq4gXmTMLZC28CQRCctNOxmM8AnFrNs4JWqJTWBkd8M/HRrqUkOLPlZV9M2CC
 x356vPkC3lU83ce3dbg==
X-Proofpoint-GUID: wzZBxJlWc-PeqeWOIBhjVVwMV7rG4-hw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEzNyBTYWx0ZWRfX0e154KHVyi6J
 ef4WeY23uEuK9Yq/yybd1QIXvs6KS4ViHv9GSi5Xkd0P6kE4LjG1JW50SwMiMfqyBtvxJfsf9ZT
 r85V2s7OLpmRFopcb9xbyHCM9VGjXUQ162w6vAVuACYdxfwxOf3j
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11890
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=10 clxscore=1015
 phishscore=0 bulkscore=10 priorityscore=1501 lowpriorityscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290137

On Sat, 29 Aug 2026 20:30:47 +0800, Wenjie Qi <qwjhust@gmail.com> wrote:
> Fault-around can map ready dropbehind folios without going through the
> normal page-cache lookup that clears dropbehind. A mapping represents a
> competing cached user, so retain the folio instead of forcibly unmapping it
> when writeback completes.
> 
> Unmapped dropbehind folios continue through the existing invalidation path.
> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Overall looks good to me. It may be nice to add a sentence about the
safety aspect of this in the commit message. Maybe something like:

  folio_unmap_invalidate() may sleep if the folio is mapped, so this
  also ensures that folio_end_dropbehind() is safe to call from
  non-preemptible task context.

Reviewed-by: Tal Zussman <tz2294@columbia.edu>

-- 
Tal Zussman <tz2294@columbia.edu>
