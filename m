Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601996;
	b=UCjCyxHxPY4vvKRhV/cT6xQ+xZnRWkPEBUrUGrHkOVbOQ2g9Wl+JVzlikBxl26ctMMPm
	 IQBlAMcELE54o/tjCshVeqSOnB3jKxJiUoX+jJBL0k/CCM9mlDvUl7B6bn0DN5qQGiQhr
	 QhEhg56tD04uVK9RzSego4GEp1EJiZigHoZyC9A4hyw9PKjvOXxLi6jZKy436xzZtrbyX
	 MVd5Icn/9lTzUQodzFNozdRpg3Nbape8AilthQBUIovmhuRWoMTEmHjpcdLK8wforl4l2
	 4E0gwCg+f9i/ubYgKHNTz5uCMA1lUia6bTxYq5pW+6F+jWBkVM6tBOjL6S2wkERy+Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S89AT7ZTjOZtL/ZUZE4jC9K4OqNH/+RoT7oEJIPYUyc=;
	b=1pesQvlKEYm9722PiAJFiv8LMwILDfAmPnsMb0Rso1XfHQr5GtPcrfMZ0UZ/E5Jm8o1R
	 rjDrGYAhqcVKMEi2+Grn5wxAJSMNd3xCtzVS3Su8BeEdeA0OokIl7QDGc8e+HsAWw956v
	 aitiFnpTXuBbRAFRfRlnx1+V1AxbbN3BkqntUlV9sz7RJwy/6gEjLjZsxRppiT8KKCMi8
	 2bW0pydsKOu7CBbZ10+9f7ZvNr9b49kK/+QEDspQLxpGyKCMpKHxV7zzsr6MAMX39NiNB
	 uU2T+K6PX1qWOL9hbJ7voSSOdmpJHB4EWK3DMqGoNHb0csG+WZco0Y1DIgYbYfn6TOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DAszUpUR;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF2606A33D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 20:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AEF2606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DAszUpUR
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-491846221ffso1458740f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 12:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601995; x=1795206795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S89AT7ZTjOZtL/ZUZE4jC9K4OqNH/+RoT7oEJIPYUyc=;
        b=DAszUpUR4ifAhi449rZywFZWHvPQQAz+BM8uD5bm4/0SI8SvLDOLgPfY/96wzX5//C
         gRPOmJlsJQ5CB+hFoQ+33L4CViCUZWgCeCEckEH4lzJyfPR21f38vUI5zjNGdEHq8gf8
         GEq6385HjahGfgYyWo593mz4LOwlOUSn5SqJCImDoZKI6Pz9rgnK3hcNMO04axRjncfm
         w7U3XWHjHRMbJqVVFYzbG2s6YUQTOFyCbgcyGHaJqheaoeYOaxdI5ukuDemZ7trh5td9
         7dmS40AazweTIGvI/gb/X07yodfuXez4FKjyFAgPeqz6hSTMYPNwoTBrm/3gUAwOUgvT
         5jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601995; x=1795206795;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S89AT7ZTjOZtL/ZUZE4jC9K4OqNH/+RoT7oEJIPYUyc=;
        b=Djv6slEzOwE4q1+3aeYoEMi7w6nyM0St3qzl8/BZd5I8+0XyXgPcuMUb3Zi+LZJWn6
         rRRIneaLVC3P8sfn04PUNQYxvixDeGdUQU40+N/4mZhzJTsTW7Xzb0ZXLKQxcptQgsEH
         MZKjj8e3619tQs+mYGJqtJggmJmfGA99N1bhYt+j20Z0tGv+mlzcH9Xil9qGmVf3X/UQ
         3HYgzn+nNGAvQXwsUQKzrP9vhSbcCbqctNRpQvuTqPq1YC77039J8JCt9BsUUPyWRlnM
         59JGKEidtBD59Nm87ZpYynxYLtAuxaFcvbn20+vRkPB52VF7AgVhvtCPRVFMaCbkNiVJ
         P4uA==
X-Forwarded-Encrypted: i=1; AL+hErHdRD0AzMDdAG8uKD774icVJ66LulTwi/HVCNB1kPh23jWyArBKedN2pMI2hYoEYN/Em30BLtUbJsrS4iLh@vger.kernel.org
X-Gm-Message-State: APuU4Z84sOzthcj6L4Bc5togWzMttcIveL26m04JP/h2EXUXmkGTaJUs
	LHzf9fzr/fm5CmjPV0F8LdaufchfeRmCGH1c/ce2vHpRaao/VvoNmQwX
X-Gm-Gg: AYBFou1jlKXJVI+iVyZ+txdzw1pka7/l/MH+MV2Btrp8TEVVVHUreqV06cqcDADD60q
	8Ox0uL/3u3EdlQjmp6/H/vBhdsM0wlSHQjl+c6zvmOdStqdGePuTgKrc/irOyM4bremcyaHj1Lh
	8RKkIyvfX5C5EICdyTbNWpxtbeK5Jz2VtCNTwR/Aw5Llc1TrCxMhMd8RSoxeBu4QUb/h652Z9y5
	Zd2Phs6k9HOndWxW8AWZWKiNidf4NECQqgC2KaIYvsfHVTw7dguSi4Ge5NtwacF9ZHmP43jCQxw
	rXBL2PK08yzDEYTkBLU3mw3yl/KVt89ygaWgjaXUO1TrvBaRAdjm+YGm+2HjYz+OLqrn7lZaI3Q
	KnLx9UNv2WHCqn8us3WEU6ZhObA4dtI1LR5+wkUu7XuA6jF2Vnhj6Zz0mcMHIpX76WOsEw5GP4b
	gc64GO4RwG+Nt99Y9SQyVi/Z4I8/jQPOgfJRO8bd24xrStuS4HOSIe5YMSnXW5HGyXi3pqMLr+G
	pdYYLTSM096tPgLh0Br5wfp9g+aZpGlZR3Cd4R8MtT72mvP8rTTtz78LX3ID2KUisE1Hh2RJhut
	tRmwVIH+jyFO7OELoGTbix/wdbrXqiT9dWQZtGN+cDiGNPMI3cw8lQzbUTqVdZFcelY=
X-Received: by 2002:a5d:59c9:0:b0:490:f98f:addd with SMTP id ffacd0b85a97d-49c6d63fa4dmr9093213f8f.4.1794601994645;
        Fri, 13 Nov 2026 12:33:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm7042380f8f.35.2026.11.13.12.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:33:14 -0800 (PST)
Date: Fri, 13 Nov 2026 20:33:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: pack fields `i_state` and `i_fsnotify_mask`
Message-ID: <20261113203313.487a3839@pumpkin>
In-Reply-To: <20261113114427.1845888-1-max.kellermann@ionos.com>
References: <20261113114427.1845888-1-max.kellermann@ionos.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 12:44:26 +0100
Max Kellermann <max.kellermann@ionos.com> wrote:

I'd use a different workd than 'pack', made me think of __packed.

> Both were 32 bit fields followed by a 32 bit hole.  This reduces size
> of `struct inode` by 8 bytes.
> 
> Moving `i_fsnotify_marks` there as well so they can be in the same
> cacheline.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> v1->v2: move `i_fsnotify_marks` up as well because "should better be
>   in the same cacheline because these two are accessed on some
>   performance sensitive paths" (Jan Kara)
> ---
>  include/linux/fs.h | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5b3a100aba77..fec047cc3327 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -813,7 +813,13 @@ struct inode {
>  
>  	/* Misc */
>  	struct inode_state_flags i_state;
> -	/* 32-bit hole */
> +
> +#ifdef CONFIG_FSNOTIFY
> +	__u32			i_fsnotify_mask; /* all events this inode cares about */
> +
> +	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;

#else
	/* 32-bit hole */
??

David

> +#endif
> +
>  	struct rw_semaphore	i_rwsem;
>  
>  	/* Timestamp for writeback list ordering and age checks (jiffies). */
> @@ -863,13 +869,6 @@ struct inode {
>  		unsigned		i_dir_seq;
>  	};
>  
> -
> -#ifdef CONFIG_FSNOTIFY
> -	__u32			i_fsnotify_mask; /* all events this inode cares about */
> -	/* 32-bit hole reserved for expanding i_fsnotify_mask */
> -	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
> -#endif
> -
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
>  

