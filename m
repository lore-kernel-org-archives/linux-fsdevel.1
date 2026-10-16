Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE544685D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142929; cv=pass; b=G71p6suZy9A4iiwCiNN3HNv3dI9oF+UrPAxe0NQm0nZoJDuIRGotdiqIxPpA5rQGdG15NgAZkzYxcp363A6papRlgpJ1xVRuM/ztN1fI2vs6dHSNoccCLmgS5BSTLAJT8msVl0i/5nK4QyhTkHNcrFYJEpaPE3SECxgh4iHZADc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142929; c=relaxed/simple;
	bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmygdeF2XO9CUSr/fPzLPN8TEgEuk6ppp+ERdlHbxg5PrkQrriAcNyjIoffGC4ZiSnyZhy2nbNMxvrEtgRgoohd2ggdzHB/MwPfkHIPzwaGiuPTZRntKyT9wE+k2coG9NepXfNSXkbHlkWRYi3CTMQzjSJ5Graal8fRqnPLIgG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rWgoZFOI; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rWgoZFOI"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35d7fa491deso814567eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 02:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792142925; cv=none;
        d=google.com; s=arc-20260327;
        b=Xv3mRJIcFj36Faxc257X57h3k7FjJfZTI5CzAolLHShuFO6fDazBk+JJSQs12gsYDR
         ZMjMmpMc9WE0DwIu1Bq8wpJpuK9fwE/dKc9flw4e2sAbvQHvx4GAYARYns63maclum6j
         m+i90zhP3mSot38iBrCE4y98SDzNbmHfbBgZ0B18EIsUNmnPDtThQGwtuF0h05/Uk9CE
         Z9ov1cexq7++ctVOzRLxx/yDRXZgYwZmwy+mTS1D3O3QbVpsaVp70U8mv7wmpBBeLaNL
         aQgj5PerCzjpqVw1EV/RlmJfbB7LuZRvtR8DXQfqwNgtDndBP86SN1Gwg9faGBcQPVVp
         +v1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
        fh=idXAAh8ed4xEs6yoVWdji2mX4t3X0Mh6kbIaMZWmqQk=;
        b=T9gu+lfufngwKzKi+5VF8wpyHXJCeRuNC/ozYv+jKIA/SwIQWFA8EUdUfSJc/L7mz7
         aSgFz3s6IKhodm6HLUtDkkn7CswMBNgEiH0LnN7clQqlXOFIUrD5w6bm4moHgYIKbfsc
         5d3OJ0SOfJ7cfISghlTDc8HHC0spt3IypQxF16OAicZogkmZZdBlSqbX5Pv2aQVhxKxf
         blNlGmmCIcJCPNtlJOZJymcuJ/4yn7fw86DBwzpRL/vd/7E7VdujYww2M/2wozeCwScX
         dn5IANu7uS0G12nyWc7mt8F89NF6lGXKzcSvdnOa1QZYmNsinWss2dIyN6MGnF1YYFJv
         Xovg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792142925; x=1792747725; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
        b=rWgoZFOIsGYNTdcPCqI1UBpcNgDM6iK4XabmpBNktpC+2RIL9Q7QvJ75g33Q1vmrs3
         jlVFtoKJNSGHY56MYrw0sx3B/i/tseUqVrks9CrP9RmhGyZk8vCken5WZWQdmxLu+31c
         jcXIVuowourWJLVyAMV5xNBWrHitgxM4mXmUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142925; x=1792747725;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
        b=FL7dlC0Oi2rFgaFNSH1en1SXqKTRQhjFqxef865w7wJEVqos6sE98nYtxjx70jWS2P
         Hhhz9IfFrV/t9OrOwH+eiEzav8eGzpYnDZKaaRKJPXik4BXtqigauTSbo5cCSKL4/xAV
         o7j/1Oc0fPw2uERFXZ8p6ShWeJIKTlieR28+j0wQInN1/aUMPO0GuRsRGr6dqGANRKKz
         9funjPP0ry2VT8UfHBm2yC7lqrZvaU4VuEw0ygoUl7d3H2uwxg1OE1F7oPdSwFwV3jj/
         AsZhqES2W+YnFIdMMg5o3//MMdkDHTBZKmLkvATWsfOmCNkwY9XhAzHLJrx2wfAoCDdx
         L1pg==
X-Forwarded-Encrypted: i=1; AKwUvByYzHyRSQPkWuk/ffSafWI9lmu3zaguy18qrpXzaD/QFD5DaJFVIk49phljzthmzlC/c3wxHALZT/TYck7I@vger.kernel.org
X-Gm-Message-State: AFq9FYKLG23bIh5HhBEII+C8ejcRs4t+ExydeEs4baFuvceHQYyMW71G
	MSllASet8K2AcojXfG7n/MmJKzcXzhEfaD8hvTBPZKTNebeU4pXdQB35KFJj556KKvNZyWbFyPl
	CpVf35jlw+kqFzLCM0F0u8aoQa+BiDLNnXmzv4qTU/w==
X-Gm-Gg: AYBFou0VRUXC9/qzKHTU48PyPWHBRCFnh5QCe2/SYGV07GlUXsBxriEhlccAj8gs+uq
	Lwyq1713NqirgPgbnfyPCigFNJx/9fW/pFKh8AZ0QeX/OV4hzZKcbYgQ/vBrdcPVPlLEQWr4Dgm
	wIWwJOwDHPhnRCSFxbpyz4WZ51rvSNTUL4f6T0g5Bg6639lZDoC01NmB0zOynPKd418UIRPStYv
	k5eUFjTxoPsyZYOFgtntD/t20CRzEpQ4IK+NOeT+PIesm4IkvPP9rE0bWYbqdpeX6B8G73tetkr
	f8CUXbxEeyoyl17eb7pOiwLyngdxlBGQ5WPmPiAe+FDSi2IOixV6SYzedzpBf8W3/VoBeHro25M
	qGFre66Y=
X-Received: by 2002:a05:7301:6f0b:b0:353:7f47:8168 with SMTP id
 5a478bee46e88-3602e69d2a3mr3111663eec.17.1792142924976; Fri, 16 Oct 2026
 02:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922081318.321686-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260922081318.321686-1-fanwu01@zju.edu.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 Oct 2026 11:28:32 +0200
X-Gm-Features: AclHuK96WMdSHWqen9On0_lt8gWo8BgW6QbnTyh16O2fTHfi3XWjbb_9a4MR3Lg
Message-ID: <CAJfpegseUy1_sw-ZY2XQQLY3ic9ifs+ar3GsxtyY90OASXu=yQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: gmaglione@redhat.com, vgoyal@redhat.com, stefanha@redhat.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Song Li <songl@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 10:14, Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> The vring size was read after virtio_fs_find_instance() had dropped
> virtio_fs_mutex, so a concurrent virtio_fs_remove() could free the
> virtqueue first. The reference from the lookup keeps the virtio_fs
> alive, but not its virtqueues.
>
> Hold the mutex across the lookup and the read.

Applied, thanks.

Miklos
