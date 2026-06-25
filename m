Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D73672A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424491; cv=pass; b=gjiWid/ARQesrbR4rQNnV3x3zDrOGiUoQUgalrgTwaM7b18iJXuFMXv2HbWQjD+QvPZ0EncALFzSPNC6vVAECwYBpeKKTq0OT66Tz8IwVnPuFjbl3mo7mwKlBCieOy6E48Ss9RM1eekrCQt9xwceMjOOPNgkUEK+Q7OGRapngP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424491; c=relaxed/simple;
	bh=hqP0C+GrCPLuEUi4frPBPhU5bZ7odll3YOOBeZVlniE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOVoMNoaNVHKwBQhPh95AlDvkpzgX5rTaP82vcW/ClAQq7lQh4zCoZZyCGqnsHuptEVKcfprioIAmxxMzwy+rod7f7Zv7OtUVUEvqTfZPJ/svEvShjePr8SnTYu733luybTm3OzDJYyjVVA5vEk088PiQdpUE19sKlNvopzaz/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTy3p5Pn; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTy3p5Pn"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-462342ac290so257251f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782424489; cv=none;
        d=google.com; s=arc-20260327;
        b=IO1jn3yiK5nttJFuQsuJmmpO244RyoVoacSHKM0Vj/WNV7hOoTlIYL7eHLMvg/Eiel
         aP6/xYpstsujheglwISEfzd8oSh/MebUZVHoqSMlDnMLoKOyV/Mn2SiXHW78B7juaw4u
         CFu/qbv4dTPHhODIPXvKTgTCjAXiiVaL4XviMthopLzyGPfqj4KW3o+pyKqQ5N6jSb7F
         wJlIIb1W0/lH+Jolfh/JN4jvbtzJkOcFMeqVapbWZEfL78smqQ3KPRY8uqPhR0wnFQcC
         W8XVV1Yph2sGhULEaogFh8mpZxIm23+gvIjkRlJSprx2Dt58oL3k7hYiRhQhZMt+GHRU
         9tiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hqP0C+GrCPLuEUi4frPBPhU5bZ7odll3YOOBeZVlniE=;
        fh=OhlCtj/x+XX7pYqW2ue4t8JC81jUAI/te9O3ghfob7w=;
        b=C0W/pTVkrrEVyOM3wkpw/RqPwCBE4Bl0nsF48BLpIJlfoDqjLt1UJzwXCc8LdEIvWV
         hF5UTVYe9cqDzgb7v8DoLevLPLFyanTIkykHCXBU20YRXRKOkPJUDdp2sR5fvAuMrh5b
         0bZkBhDbjisHnjushHiIi3JRsIBhx1ZGJ2kA/dQP+1nxPlyp5kMSvHGg3/SbPby0cW9S
         5RuCI+9HGDMUxppyjz+vdmfLanujwC4mSEx3h/vbhZbJXbwtwmO2cNMV4AMzpukVCynQ
         3QmL1+I7OsmoL3az9h7o19cn4khu4O5ZWa6mqFBA8K867KgzewzAzkUheysYF9tYwsWN
         uqAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782424489; x=1783029289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqP0C+GrCPLuEUi4frPBPhU5bZ7odll3YOOBeZVlniE=;
        b=oTy3p5PnpdhOt8pLLym21CDbOMfOHXzrTElw+bGqEG8Eehw0AL2ouiB5Bthfq/nRJe
         /Q10F2ZhtCJZfOce8TdmxL/sokaqz6R2ROAcUECrr6dAUxz+Q3T6IuT6rECIO3g0v/OA
         pWuoNNVRNkwa3HIs7UkhF9S/BOo4bRIG2jY/nvkwe6QIyjp1dffGYCYpF2PI1CfM0J26
         h3YLepyHMMtzhNhwh34PYwW22uZuIA1g3lGiBj5mZoV8SxSX+bDARt44dj6AdoT0QikL
         CWdphhhE5oGMQ3uBrW+auAe6t0dgVM2rg3aOUVan5xRuuFifgBjQLQneo3tUDaceDZxO
         Ew4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424489; x=1783029289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqP0C+GrCPLuEUi4frPBPhU5bZ7odll3YOOBeZVlniE=;
        b=fP1jWj5VkjrJjZPYDNARHfX7Q3fAWq+etrAeP5fTxgRbvFQuZMi+dKeDhCxOnvgGqX
         G+Dpo8ccjl5GMSoMmh0TxPS8G/zA4RWYL7v0KLXpmPMBsVvXUJzihWK/a3tlv36DwVlY
         CWwQFTr1mVJNfel5o5bVoa5bfGhtUOZEFGFSF0FLqAGCpnLV7DuUgiL6geYFrYI1/vXF
         XrTXY4K31G0Dg5XI4iULVhZG6GFLceZU3nwwmbVJH0zndGop7rI6LugetJENeihKrLO7
         eH7xHZUxqgSrjb0XMvUu7dmcbMjADXlfr9GC5hC5DU/AD9jvcZh+5YogwhHa+ICS/CLQ
         wy/g==
X-Forwarded-Encrypted: i=1; AHgh+RrrMgU6FLYLVbHcEYnpMYts7rjOsoIxw6uKaIjfTeR+KKCf5h68A8w/ZTrQB9hYhqxx8c4lfYxBRPb3a/4l@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZF4sZH8dDK3VU+X8ivlE5zqeFgSdZRlPM1TJrB1Xtkz1n1dU
	4Foh5BdO/2vM8vcIX2JOrnOHP5oHgaHlG3Qgxl2n+A27+0kOCbfwQBohXXbRtRnDFewZvrG/HAa
	gux+cql14zgh10txxHfWWUfUBP5WNeIk=
X-Gm-Gg: AfdE7cl0SO1EmmzYlgOIXdpLPaoSJKgHHOnm8c2FC/mTpIo4rWg1y6fVHnXr6lHGvd5
	tv1Ym0a6VxBSH/cGSa6GcxezC0silYoOK6yMt7qlCpkk+zBKE+WzG9XR8VO2K4z+OOFUGYT8I4A
	NT5fu0lLmZjFV3TQ3xLHnfAt4akdW9urwpEDyK+OfgkqxWTjmXWC4wODW4mdCti741pgMgO9i6Y
	KLJYCCs52KoPDysmpfzb3xfXI/HOpI+xBPoDN/qsMu7OxbalHmc3aLepTjf+dMxgvppC4YyzpMA
	z2tVWyfHDt5ETflLS4c3rJbBUzF1H9Q/rlPhyagFH3tgJjWYI01I
X-Received: by 2002:a05:6000:3109:b0:46e:6684:4665 with SMTP id
 ffacd0b85a97d-46e66844690mr3903048f8f.4.1782424488674; Thu, 25 Jun 2026
 14:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624212925.1668662-1-joannelkoong@gmail.com> <20260625-zeilen-allein-beimessen-2f631e840538@brauner>
In-Reply-To: <20260625-zeilen-allein-beimessen-2f631e840538@brauner>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 25 Jun 2026 14:54:37 -0700
X-Gm-Features: AVVi8CdgcDeH4L7ba7ny6GntgJ_zpXfkq2R6ExpkAUsTrggKSXyXk2XE0Qy7MbI
Message-ID: <CAJnrk1Ypq2r+xofROACMRJ_QTtAJC1wJueNg4uCvnpDnWyYLXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iomap: add helper to keep uptodate bitmap in sync
To: Christian Brauner <brauner@kernel.org>
Cc: willy@infradead.org, hch@lst.de, djwong@kernel.org, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 12:46=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> > This series is on top of the main linux tree [1] because it depends on =
some
> > fuse changes in Miklos's tree that were merged into 7.2 but not yet pul=
led
> > into Christian's vfs tree.
>
> So I pushed out vfs-7.3.iomap based on current mainline. It'll be
> rebased once -rc1 is out ofc but so you've got something to base things
> one.

Thanks, Christian! I'll base v3 on vfs-7.3.iomap
