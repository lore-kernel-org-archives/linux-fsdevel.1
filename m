Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037652;
	b=OzCyH4f6F6c0k7UAynMVjtRdQnkxpSyiH84HTLa27tlwCeWSWUNrFbqQMbppOsHyWcee
	 2cNjOYAgXfsJ1qKgRonB94jJppFaK0945BwBJ8PgpEEyIsX18g7ZDym/dYkyVVWXnmBnF
	 NxtbS0CIiukANdMiZyokE7qoO/G0gUUDXoZBLiuup9w8NHPB/nHFZuwpFpF8wQY1xp0O+
	 PRzC0vvAJ60vs86q71QEPA8+Gfutf+/+Au1IsXZZNIZ073XhR/CnpaoGU2bHqih5vcbmA
	 fJz4HhnJOJ+tdilwkDFVQJmEmjaWl8V3dGoHhw+PIljFPIrvy7rUPBAmqyMc70iffFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037652;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=LujwpVj4cN3VcsAbHQOoi/2DXadgDaHN7RsFdQlj6xA=;
	b=EhgKOUtwq5L9JH02/HArOK72DsDjWJISgoXsmZHEC70s6SDE2QdKz+l1yfjok1mjEVel
	 LsfSiNzWb0t9rbHTiUn5EZc+mpHX/Td00ShDWpbgkaN/NsS91LLT1IDDleaQL12V3JWZQ
	 T/CyohaVXNPjwr2BuvvCoxMNpk3KjW1gIxIww9Do/qi2MX9kLgdNY4b0XOmTEFwKrWx5p
	 CbQ7BfojlqAtD/Y+xuvD3McQhDmFGBz+JZ8entIL2B4u5xe54jxue84cSMk4PHYrNY6Lz
	 ZzwM8G2YUEYRE4gUHZLxu36b4Kej2NF3yvUXpWzPgR9xCKkHB/ddv/wOUZ2dIDThHWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=m00WD7jR;
	arc=none smtp.remote-ip=212.227.15.14
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6E606A31A;
	Mon, 26 Oct 2026 18:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CF6E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=m00WD7jR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793037641; x=1793642441; i=markus.elfring@web.de;
	bh=LujwpVj4cN3VcsAbHQOoi/2DXadgDaHN7RsFdQlj6xA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m00WD7jR3y0DP4OYYx+0a5fM3PFcyoc/QQKUzbZiYbqUSwP9EIvBtz+MGTTp1kfJ
	 2s0InDdE7oP3vtoEhYtZp1w99cHAicmIQR/Z2U91aAoPV6RQ5czOFXmwDp3zfIwag
	 W6dMRJuIHjFBNCKEBMLWHSFlrAuOzwDoC+znVmnCNLuXcPvtyr0ZPbq8p3h93stJq
	 tlVm5NTvcKi5M1ku6jgvwZbdpQInhDOu7lLcTLdc12THpm/JxKtKSpR4qngl7stPJ
	 x/rXbQUElfUiXk9ns0LUg/E51zwp9D47RRxlLH0S45fAVlDMo6CTaCDc3zgQkwOur
	 O3VvxGjjbO48m5dJJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1ww9wr0udA-00PNzq; Mon, 26
 Oct 2026 19:00:41 +0100
Message-ID: <773c7445-8d4b-4d94-a995-297ecee9c879@web.de>
Date: Mon, 26 Oct 2026 19:00:39 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Song jeonghak <thdwjdgkr123@gmail.com>, linux-fsdevel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Yangtao Li <frank.li@vivo.com>
Cc: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com,
 LKML <linux-kernel@vger.kernel.org>, Edward Adam Davis <eadavis@qq.com>,
 Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20261026152139.458677-1-thdwjdgkr123@gmail.com>
Subject: Re: [PATCH] hfsplus: free failed b-tree nodes in hfs_bnode_put()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261026152139.458677-1-thdwjdgkr123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a9KOd70bH34IRb46w2toZQkq/yKMxESz4/UoVXYQzl3R9NJ9VU2
 W11suGmJrZj8Odcgu2ZNUxNzQNxebyNNYlZmDCS5NxutU8WuyQ7w1Ni8PecAp7j+LPM17P8
 XZdbX0nespKDfoiDn8wgozYbY8ggDx1nu3pAvTDZUuW45D7tv3J2rpitMJHRhPTLqoAOp78
 w9OscB1rynWVND0jOCyrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+iQ+HgqmJoc=;Av8YWm3yh1zV4vlK/5IEZSBenGh
 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

=E2=80=A6
> +++ b/fs/hfsplus/bnode.c
> @@ -702,6 +702,14 @@ void hfs_bnode_put(struct hfs_bnode *node)
>  			hfs_bnode_free(node);
>  			return;
>  		}
> +
> +		if (test_bit(HFS_BNODE_ERROR, &node->flags)) {
> +			hfs_bnode_unhash(node);
> +			spin_unlock(&tree->hash_lock);
> +			hfs_bnode_free(node);
> +			return;
> +		}
=E2=80=A6

How do you think about to avoid a bit of duplicate source code?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.3#n526

Regards,
Markus
