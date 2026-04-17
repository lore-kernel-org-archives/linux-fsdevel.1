Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9631F987
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776463404; cv=none; b=t8H8FNRfOvAAe+UAzhLvtZgCxRUZlgEqREX+jHu2iTedB4xdSXll6XTRpxz00kBB1NcjNyaN7hS2kvRvVuEspNdrjs51zt4q1xsycnT3eBOlT8FYOyyhwnjtpJAvaeU//+PCQARSJtOIrlUd6ICyttO9wx5u+bCZN0ZI2ZjO1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776463404; c=relaxed/simple;
	bh=vB41k32LbV2UonMRsmOb/yQltXeD3/4LUHEJBQeG5bM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TUcs5hhsT+Z8MukggslY96Ljb0p4IjTpsCNgB9mnldo3jIKFDLCO9ZqEHBEr1F09PE5+kCsawcsgrR3pMeOIb3JKSF8uSdp51k4tT41VcN3C9QiDIWB+uFlMQUIZgZFL2Bwpavm2dbGybrahz/QyOVnF/3fNIrrvYS19Bw875/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDjqyYdL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdbLlWLw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDjqyYdL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdbLlWLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776463402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1q/hOKAYMwZs39a5k42c08xi2TGEQ6H1qxtQxkEfyg=;
	b=QDjqyYdL82y28jf/ocx3RyxCra8BRme9G2f7NIUXzXg0xE3vsPBhJRrwlweq8vv84hvGGC
	GSp19BEi9IMj18YGfv7oZJR4dLbiSD82/yo4ZYfQe+ssHLd0NQaj2HiyKAVGLBnBMljMUs
	aiskCs851WyJta38pj9hrYmkdOYzz9w=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-3OfkSLzQOfmjmJjJilXZKg-1; Fri, 17 Apr 2026 18:03:20 -0400
X-MC-Unique: 3OfkSLzQOfmjmJjJilXZKg-1
X-Mimecast-MFC-AGG-ID: 3OfkSLzQOfmjmJjJilXZKg_1776463400
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7b7e80f7a8bso28037757b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776463400; x=1777068200; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r1q/hOKAYMwZs39a5k42c08xi2TGEQ6H1qxtQxkEfyg=;
        b=cdbLlWLwt/pr5U9g+iTaF7NRKG1bv9RNZmXKFemVMMk9895QaoOKArU25zxcIRAZ5h
         AVavqVbvpcpvaHHacecoezcVa8OhEO5y9BNXs3lnzmQ5+gjNfA8Kl9nRIdjo8TVflORm
         3HqFgjV2QzUfDl/8N3vwH+x4fyWDpynE2EMpVXqbVwvGLlCIXw8yCs7y4SP87TWY6Wjg
         uSzXAXJPGaHeiBM/7ejzGJLn7y6w7qH5CiI3EF8fX1QVd1KdlQpkCUxuBbaCPID85MOx
         /8wJA3d7LrpYoXjkkGUwhragjWxjzokwJuywBeLUQvxuaRMR5BJSE2wLIAQLHBtUNSkU
         skQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776463400; x=1777068200;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1q/hOKAYMwZs39a5k42c08xi2TGEQ6H1qxtQxkEfyg=;
        b=oc+yQ5TTgu1SEd14SZH//rAIlRqsMdwu2RJjw/pTWVDkduqcJ4DvWja6qaunE4uuFj
         3dOZ1URe+lKV1paSk+8Jq1D5ZPkDgsAA702RbvgT9st41mNRU9LLMBcK0pJymuvCZ4a6
         FHmZzkYjOftOiKiMhgmqBmT2yvXsOzzOa2D1GhJhA/0iJe2kh/Dyen96xmrNM960BuWE
         bK7Nsqe9MgvTHS64wftqKm0xiX+eZ/J7wjPc1K0SHKgcGCYJ5wzfAkx4JSZkUx4nJUAW
         dJIc7J/vggGCI7n3OT9393JBCMmYnHPHWhl8G58eys12UpJRF2ibyuIzLjBdSPlfZVmp
         K7zg==
X-Forwarded-Encrypted: i=1; AFNElJ8mr9IjTSuEOwxPrOJ15r9UpjyzmahyI/XurzsHZA71xeL77sDgrgTIBo5b/x/0QQyM42/Y+ztKkz8ci6pT@vger.kernel.org
X-Gm-Message-State: AOJu0YyanhVaEXOWRLtz1Yp6RgOYmf5JD+15T7iGyvKGDVUk+ZoEDSLB
	9n3/pcFN9b1XYbdPGpHF9+EqwIWHg/lbfwo45c700D0a4cD3kJ8GK10bQHk0oekCvluyJyruUpo
	k7qYqOu89LOV9j1YF/CUabunn3+2/osoC5DhSyR3HY10WClu9H/DvsLtpxCMlV8u/+aQ=
X-Gm-Gg: AeBDieu7ovDiVnrW0jHAwYauwq4b+MFSv10ed2VAVGYIqo5w7+VOLrZYc67MEvjOFi6
	jxiHtdBbQjjc1s6HgSjPOD3UpPFRlVUQHT03OTTzSQSk8dH5rIszlM/rI6aHx4Nehk258LCreO9
	cOkubus787fTJJDvJDUK7ZYiWT+oNTRW5jvmIKhT/50yT8TJ4FPxXT0NDp2wf9gzcK6YwCf3mjW
	0P08H2okpe9DgU3lG9uitSVyNwRpileDlEJCGWgkIz8ELPioYAwLeZkpmmqRgyjDSYfLIZoD8uL
	10YiZBX+i25jBnRo6Jn+evL5UoHQtJCcs7MP4cVWkniV2VKx5+2RK+UUOzsPOjruIqPPyr2Vsjb
	k0sO9YV2eotgSjP55hGTKOlW0CyhEIQptAkcjZxw+1DbPBzsQDIgTJFgrPUJ7y10=
X-Received: by 2002:a05:690c:d8d:b0:7b1:fa45:72e3 with SMTP id 00721157ae682-7b9ece5ab23mr56682507b3.4.1776463399667;
        Fri, 17 Apr 2026 15:03:19 -0700 (PDT)
X-Received: by 2002:a05:690c:d8d:b0:7b1:fa45:72e3 with SMTP id 00721157ae682-7b9ece5ab23mr56681897b3.4.1776463399096;
        Fri, 17 Apr 2026 15:03:19 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99b672sm12846097b3.29.2026.04.17.15.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:03:18 -0700 (PDT)
Message-ID: <60605973b66496b04c6847ceb6fa46dfada6a628.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: Supports freeing newly created tree head
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 slava@dubeyko.com, 	syzkaller-bugs@googlegroups.com
Date: Fri, 17 Apr 2026 15:03:17 -0700
In-Reply-To: <tencent_C4F16CD096B0EAEAEE5ACDB07A266E382C0A@qq.com>
References: <69e1934c.a70a0220.7229.0011.GAE@google.com>
	 <tencent_C4F16CD096B0EAEAEE5ACDB07A266E382C0A@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-17 at 14:58 +0800, Edward Adam Davis wrote:
> hfs_bnode_put() does not support deallocating a newly created btree
> head node; therefore, regardless of whether hfsplus_bnode_find() succeeds
> or fails, it cannot effectively reclaim the memory allocated for a newly
> created head node.
>=20
> When finding a head node, if the node is a newly created one, we can use
> hfs_bnode_free() to reclaim its memory.
>=20
> [1]
> BUG: memory leak
> unreferenced object 0xffff88811cabc840 (size 96):
>   backtrace (crc 3e2dadb7):
>     __hfs_bnode_create+0x59/0x310 fs/hfsplus/bnode.c:469
>     hfsplus_bnode_find+0x13e/0x580 fs/hfsplus/bnode.c:547
>     hfsplus_btree_open+0x2fa/0x6d0 fs/hfsplus/btree.c:382
>     hfsplus_fill_super+0x272/0x880 fs/hfsplus/super.c:548

I need slightly more detailed and clear explanation how the issue has been
happened and why we need to fix it in a such way. Currently, I don't have t=
he
complete picture how this happened. I am sure that you have the complete
picture. :) Could you please share what you have in your mind? :) Don't hid=
e the
wisdom. ;)

Thanks,
Slava.

>=20
> Fixes: 8ad2c6a36ac4 ("hfsplus: validate b-tree node 0 bitmap at mount tim=
e")
> Reported-by: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D98547b0428b6a6a3467c
> Tested-by: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/hfsplus/bnode.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index f8b5a8ae58ff..65902104882a 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -598,14 +598,18 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *=
tree, u32 num)
>  		if (key_size >=3D entry_size || key_size & 1)
>  			goto node_error;
>  	}
> -	clear_bit(HFS_BNODE_NEW, &node->flags);
> -	wake_up(&node->lock_wq);
> +	if (num !=3D HFSPLUS_TREE_HEAD) {
> +		clear_bit(HFS_BNODE_NEW, &node->flags);
> +		wake_up(&node->lock_wq);
> +	}
>  	return node;
> =20
>  node_error:
>  	set_bit(HFS_BNODE_ERROR, &node->flags);
> -	clear_bit(HFS_BNODE_NEW, &node->flags);
> -	wake_up(&node->lock_wq);
> +	if (num !=3D HFSPLUS_TREE_HEAD) {
> +		clear_bit(HFS_BNODE_NEW, &node->flags);
> +		wake_up(&node->lock_wq);
> +	}
>  	hfs_bnode_put(node);
>  	return ERR_PTR(-EIO);
>  }
> @@ -694,6 +698,10 @@ void hfs_bnode_put(struct hfs_bnode *node)
>  			hfs_bnode_free(node);
>  			return;
>  		}
> +		if (test_bit(HFS_BNODE_NEW, &node->flags)) {
> +			hfs_bnode_unhash(node);
> +			hfs_bnode_free(node);
> +		}
>  		spin_unlock(&tree->hash_lock);
>  	}
>  }

