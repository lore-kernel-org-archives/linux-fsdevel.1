Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7B372EF7;
	Wed, 18 Mar 2026 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821805; cv=none; b=tTNRWdhrqVMWAHEcUhQn0egZku2Uh1NxmMKzDg2M6VFgkMoAhJKidFRPv2MlBSQgIQzcsX7MQf+Ro4Zp4aLHKdbzkxCf12RRH/eNNtS8iG+yi9vQj2iVvqCbzWcKlTZANTpUyyiBX/Xljj5doAtLlnHICXTctlNwAVTHcGO65BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821805; c=relaxed/simple;
	bh=DSl1FYzD4kRYOTmS/bHj9WQY+yAPB8qthbD8WKk/uJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOFKOzW+klrxTAQhPX0+pZLB8qKoRB7tciphcgnPwzMkKWffUfMOaiXQHvV0CPYvTjZPMdeDlaP9hecbQo9uvIBUn+d1UUOlfPFwC0G7TXi3WOtVhondNdB2StvgqT4bdRV7IEpNLC471UuBpan8ayYlgGeTF77Yv2pqxWDOdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62I8GBZF007932;
	Wed, 18 Mar 2026 17:16:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62I8GBd4007928
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Mar 2026 17:16:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <74c40122-ce49-466b-9c03-be392c2b0f44@I-love.SAKURA.ne.jp>
Date: Wed, 18 Mar 2026 17:16:11 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
To: George Anthony Vernon <contact@gvernon.com>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
References: <20260311211309.27856-1-contact@gvernon.com>
 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
 <abntindMnlpodsNj@Bertha>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <abntindMnlpodsNj@Bertha>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/03/18 9:10, George Anthony Vernon wrote:
>> Because of this endian bug, syzbot did not test is_valid_catalog_record() == false case.
>>
> Sorry I don't follow this. How can you tell syzbot did not test the case?

Since is_valid_catalog_record() returns "true" for 0 < cnid < 15 range,
hfs_read_inode() was not validating the cnid which the reproducer would
have hit BUG() in hfs_write_inode(). And the reproducer did not hit BUG()
because BUG() in hfs_write_inode() was removed.

---------- (Run this program on a little endian machine like x86_64.)
#include <stdio.h>
#include <arpa/inet.h>

static int is_valid_catalog_record(unsigned int cnid, unsigned char type)
{
        if (cnid >= 16)
                return 1;
        printf("validate %u\n", cnid);
        return 0;
}

int main(int argc, char *argv[])
{
        unsigned int i;

        printf("wrong order\n");
        for (i = 0; i < 20; i++)
                is_valid_catalog_record(htonl(i), 0);
        printf("correct order\n");
        for (i = 0; i < 20; i++)
                is_valid_catalog_record(i, 0);
        return 0;
}
----------

----------
wrong order
validate 0
correct order
validate 0
validate 1
validate 2
validate 3
validate 4
validate 5
validate 6
validate 7
validate 8
validate 9
validate 10
validate 11
validate 12
validate 13
validate 14
validate 15
----------

