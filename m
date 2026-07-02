Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9538E121
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996338; cv=pass; b=h3qdgHS5RXJU7ki+TZ22KnchlVeuSaEC1+/y/3zSZP9jTNcGkUIBXo+vUIDMzsP63baOC0RGEvXmkTrNZoaJRfo03oFFDukVPdgDGj/lySbRISSom1elavIIrAUqL7s6tiL1XDPlssEWoBabj4/h36uRs/VHo8cFj5Lr/h/tZbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996338; c=relaxed/simple;
	bh=YfuTP/ZRleT5u8JPEbY+mg8sn8oDE1H48dUxEJLwHHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHCpw14tuVAwCT1U16TdQ+l9aUldglZ6lBqfHVGAFhWZTJlMgOu+V9bWK9n0lFDkbKCpvQtcmJs3ZULxZ4f9jzSoB2aB/PFj83hWchl4nLnmd3sg5kkY6mhDVXXdjF9NRD4iq1R7QmAO8Px08v8Q/b5WvXByMwMGLs/2Pv3Q3kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stG3jPxX; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stG3jPxX"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664f0a76a74so2257333d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 05:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782996336; cv=none;
        d=google.com; s=arc-20260327;
        b=Mc57Eu74DOX49zWM3Qd0097pXbZupl2xGFy0pB87VRDjNnQw4G/Ev+nBu7twMC4s/H
         u4Nc9nbfp2GfK6g3ZvXTt/hFkvUaS9w1sCcfMN8JHfFAAu0sNJbvOPR1tCGrp/R5T+Fc
         rm1C8oK8V6jDwJ0wkMy3hBWAb2Lv0YeSjPgHiaY8gLVUZvzutSUuMQUmS+JySqHYNb1U
         T8xEx4GyM6QZd9/sCZZnVh3fvlFrgcv0GWYEPJ3ydxAoOa0vMjRDzxDn2um6cbaYi3P7
         FwxueGzv8PpA+IOdqAwSQIrE+VeQ+grx08tOI0hPV6MBbe0XEap4UScr6A44LwDPTSvJ
         /D/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1LTF2zi6k8qqnOoUHhbldZF0g+S9mvdrS4GbbTxAt6U=;
        fh=ElGcNglI54lU5kR1SdudlRryTPQrCCginaSDQffGBZ0=;
        b=oHJIoYUjNhmIqGQ8y83Td6/X7z8TtSwrw2N4/GvFIsk4Px41MgWpSgypjTwsI05Wvf
         MJgrj9lFQ592hOBfEMvE6uIuEWzEZ2k1njBPibKCoyWiVlaaQL+m60cL/tEI3cMfUxbp
         UpFnjhJK0d6a75sVeL0NjIy2ag6x2eHmYg3b6hU1iNMpqE+CU6M1wdxPZVodTGpy+a2s
         p6OVaN7DhH55P3OSqiYQqawpr1qlN44TT+hqvxMtNAywg916MdDQgWaiJec72zb7NewJ
         wqF5EwO/blmTNHerCtOnHNCM/tGeUara9iWMda/IvQR8/rFJypywgG+1mXFcV2DAfFwx
         RclA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782996336; x=1783601136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1LTF2zi6k8qqnOoUHhbldZF0g+S9mvdrS4GbbTxAt6U=;
        b=stG3jPxXPnMRcSQjMNoyaY7Ikf81aZtjiowVDv7NA9ilAqjcWnbAxtfiqqm4gtGFtJ
         2MSXxETFrNqDf9zRV3E0wF9h3vCR00aY+zBwnyZ++fRtHdsqE8FeubfXot4HcMfQgLAI
         TfOlqSWNeCCCECD4GtvrIZhxBDv4AVSJp9K3WkRWY5Gp59YHmZ3eZh6QCDjVWFZexsJg
         WzJUg49Ysa5YHg15oXMLkAxZbV2eY/E5dpeY/9HBpYx51c/9z04smPlMDjkEQ+KooZ9t
         Ly0avz/dYpOzYcfNddtBy+2/empiTtsPg3VuuSH8iJuXfKj5N04GWf2kWPcb5mk+QKqM
         lqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782996336; x=1783601136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LTF2zi6k8qqnOoUHhbldZF0g+S9mvdrS4GbbTxAt6U=;
        b=TNjU6WwZApR5V2Au6MwH/kEz/0jAtsEz2Lf2voFROR+WJJWopjsHimfjNFi65r9eCM
         ul3aJZ3IXD+o3kzt/cLuwV1X0u8xOqGvFXDCyUeKZuWUJYATfCigXVAVYNXjLku4OmXE
         lxaKVU5LqI1wEIo0fvkalswOjmVIRl37+9qI5Elex2DScLefjOJwMy6HgdOkTsBIbJVG
         NAng2y9GlOO/d/AG7ZYm8eRuAv5wgWQev0O/RUCvb6RBmYIvc8toc4vLrnnOt2BNP3oI
         DB5F0DXcfylmkcL2rdp7D7oGYt8Wjk09cQF1f8HoOFHO1+2+X0PrGDO9WWofabQPF9dw
         QbBA==
X-Forwarded-Encrypted: i=1; AHgh+RqowUyOZed+ugOhMhCant7kzwbSC1LR+jp1SnbV6GwF80m2FoH8hNnAbdDiMoKbkXnS+Yy/1zjmfeRiaV/F@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1ye1h7a/leyL0ATTnqIbfvsLdMpYn5fFiBdpRkWBX8yqYMZV
	qwloF4TwWfJA7ZeRtEh1+7RJpMN7EynWs8CHoiFvZSaHBXgsC3PQL4QugQFHks307mK4vbMrbel
	AXpeNI4P6dDF/9p5c2dW2tRNzkGKUQdc=
X-Gm-Gg: AfdE7cmfzSkvjq12oFpBIpBVbhsVT3r9BUPjxmva2RJV3z3A0Jw63cjz2anvjWWsFFu
	Z/BbnPZAj/NJu41w/y+uY2U3T8IkSqYB2dXjbZNXqE44eow38u/E12QVStAsLVizsrpK7+CfztF
	hHFLnR4EwPnPhqpAJ6gXWCS0KB74mIh+hWA4GMZw3VHDs/sZxslK4//+Mq+IX0VT2MMonLNlrb4
	4SOKu17XMjWMjO/4Xw33/vNnT890uck+eAf4aoReS58lSYlEB5BUPQa6HT+DPIIr594C2DR5Ydb
	lt7QvNt52q/YWald9SB1+ynaF49T1cs=
X-Received: by 2002:a05:690e:1289:b0:662:dcc4:c6bd with SMTP id
 956f58d0204a3-66521a6e36bmr5861205d50.34.1782996336401; Thu, 02 Jul 2026
 05:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702050724.1658-1-aditya.ansh182@gmail.com>
 <3sbocdflzeajcievmbdwprrgzkztd7ogn7mmjx4quptorotwak@rlzklako3yht>
 <CAK5ssPOM-rddJR6=QJ4RSCeQvamKKAbJS+NCOLbsC2eSODydkQ@mail.gmail.com>
 <zwfhyqxdxfigm5nced3hgsp4mygwxgwc4cxzeyl7glrmie73rm@r66bdrw7fjsj> <CAK5ssPPPfkL889aCK_z9EnDNbKBuHRQd45uLzXpeUVrVkFkzbw@mail.gmail.com>
In-Reply-To: <CAK5ssPPPfkL889aCK_z9EnDNbKBuHRQd45uLzXpeUVrVkFkzbw@mail.gmail.com>
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Date: Thu, 2 Jul 2026 18:15:21 +0530
X-Gm-Features: AVVi8CcVo-eNxK1YaN3wDQSM42J7VF1rgCK8uZiy3AfWHDTqxEpsOP0UeyEofZY
Message-ID: <CAK5ssPOxredbV5dDsyc4YLdDBVPEv5b6qOKCxiWPLMWSc7VyaQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: use fsdata to track inline data write state and
 fix race
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Tao Ma <boyu.mt@taobao.com>, 
	syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jan,

Thought a bit more about it. Treating fsdata as
bitwise flags rather than mutually exclusive enums is a much
cleaner and more robust design. It completely decouples the
different write path states.

To implement this, I will define:

#define FALL_BACK_TO_NONDELALLOC 1
#define CONVERT_INLINE_DATA 2
#define EXT4_WRITE_DATA_INLINE 4

This ensures that the flags are fully independent and do not
overlap.

Regarding unrolling the state on exit, there is a slight
asymmetry in the VFS interface. ext4_write_begin() receives
fsdata as a pointer-to-pointer (void **fsdata), while
ext4_write_end() receives it by value (void *fsdata).

Because write_end() receives fsdata by value, modifying it in
the write_end handlers has no effect on the caller's
(generic_perform_write()) local stack variable. As a result, a
stale EXT4_WRITE_DATA_INLINE bit would remain in the VFS across
a retry.

To handle this cleanly within the constraints of the VFS
interface, I propose clearing the stale bit on entry to
ext4_write_begin():

static int ext4_write_begin(..., void **fsdata)
{
...

/* Clear any stale inline flag from a previous retry. */
*fsdata = (void *)((unsigned long)*fsdata &
  ~EXT4_WRITE_DATA_INLINE);

...
}

This ensures that:

any stale inline flag from a previous retry is cleared from
the VFS stack variable before the next attempt;

the FALL_BACK_TO_NONDELALLOC bit remains preserved; and

if the retry prepares an inline write, ext4_write_begin()
simply sets the bit again.

Please let me know whether this write_begin unrolling approach
looks good to you, and I'll submit the v3 series shortly.

Thanks,
Aditya
